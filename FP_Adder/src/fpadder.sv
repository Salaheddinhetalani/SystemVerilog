module fpadder(output logic [31:0] sum, output logic ready, input logic [31:0] a, input logic clock, nreset);
                     
enum {start, loadA, loadB, specialCases, alignExp, addMan, extractSum, normalizing, rounding, packing, result} state; // to allow inputs to be loaded in succession

logic [31:0] n_sum;
logic a_sign, b_sign, x_sign;
logic [8:0] a_exp, b_exp, x_exp;
logic [26:0] a_man, b_man;
logic [27:0] sumResult;
logic [23:0] x_man;
logic guardBit, roundBit, stickyBit;

always @(posedge clock, negedge nreset)

if (~nreset)
  begin
  n_sum <= 0;
  state <= start;
  a_sign <= 0; a_exp <= 0; a_man <= 0;
  b_sign <= 0; b_exp <= 0; b_man <= 0;
  x_sign <= 0; x_exp <= 0; x_man <= 0;
  guardBit <= 0; roundBit <= 0; stickyBit <= 0;
  sumResult <= 0;
  end
else
  begin
  case (state) 
       start : begin
			state <= loadA;
               end
       loadA : begin  
			a_sign <= a[31];
			a_exp  <= {1'b0,a[30:23]};
			a_man  <= {1'b0,a[22:0],3'b0};
            	state  <= loadB;
               end
       loadB : begin
			b_sign <= a[31];
			b_exp  <= {1'b0,a[30:23]};
			b_man  <= {1'b0,a[22:0],3'b0};		
            	state  <= specialCases;
               end
 specialCases: begin
        //if a is NaN or b is NaN return NaN 
			if ((a_exp == 255 && a_man != 0) || (b_exp == 255 && b_man != 0)) begin
          			n_sum[31] <= 1;
         	       		n_sum[30:23] <= 255;
         	        	n_sum[22] <= 1;
           			n_sum[21:0] <= 0;
          			state <= result; end
        //if a is inf return inf
        		else if (a_exp == 255 && a_man == 0) begin
         			n_sum[31] <= a_sign;
          			n_sum[30:23] <= 255;
          			n_sum[22:0] <= 0;
          			state <= result; end
        //if b is inf return inf
        		else if (b_exp == 255 && b_man ==0) begin
         			n_sum[31] <= b_sign;
          			n_sum[30:23] <= 255;
          			n_sum[22:0] <= 0;
          			state <= result; end
        //if a and b are zeros return 0
                	else if (((a_exp == 0) && (a_man == 0)) && ((b_exp == 0) && (b_man == 0))) begin
         			n_sum[31] <= a_sign & b_sign;
          			n_sum[30:23] <= a_exp[7:0];
          			n_sum[22:0] <= 0;
          			state <= result; end
        //if a is zero return b
			else if ((a_exp == 0) && (a_man == 0)) begin
         			n_sum[31] <= b_sign;
          			n_sum[30:23] <= b_exp[7:0];
          			n_sum[22:0] <= b_man[25:3];
          			state <= result; end
        //if b is zero return a
			else if ((b_exp == 0) && (b_man == 0)) begin
         			n_sum[31] <= a_sign;
          			n_sum[30:23] <= a_exp[7:0];
          			n_sum[22:0] <= a_man[25:3];
          			state <= result; end
			else begin
            		a_man[26] <= 1; 
            		b_man[26] <= 1;
          		state <= alignExp; end
      	     end

  alignExp : begin
		if (a_exp < b_exp) begin 
			a_man <= a_man >> 1;
			a_exp <= a_exp + 1; 
         	        a_man[0] <= a_man[1] | a_man[0]; end
		else if (a_exp > b_exp) begin
			b_man <= b_man >> 1;	
			b_exp <= b_exp + 1;	
         	        b_man[0] <= b_man[1] | b_man[0]; end
		else begin 
            		state <= addMan; end
             end

    addMan : begin
		x_exp <= a_exp;
		if (a_sign == b_sign) begin 
			sumResult <= a_man + b_man;
			x_sign <= a_sign; end
		else begin
			if (a_man >= b_man) begin 
				sumResult <= a_man - b_man;
				x_sign <= a_sign; end
			else begin 
				sumResult <= b_man - a_man;
				x_sign <= b_sign; end
		     end
            	state <= extractSum;
             end

extractSum : begin
		if (sumResult[27]) begin 
			x_man <= sumResult[27:4];
			guardBit <= sumResult[3];
			roundBit <= sumResult[2];
			stickyBit <= sumResult[1] | sumResult[0];
			x_exp <= x_exp + 1; end
		else begin
			x_man <= sumResult[26:3];
			guardBit <= sumResult[2];
			roundBit <= sumResult[1];
			stickyBit <= sumResult[0]; end
            	state <= normalizing;
             end
 
normalizing: begin
		if (x_man[23] == 0) begin 
			x_exp <= x_exp - 1;
			x_man <= x_man << 1;
			x_man[0] <= guardBit;
			guardBit <= roundBit;
			roundBit <= stickyBit;
			stickyBit <= 0; end
		else begin
            		state <= rounding; end
             end

  rounding : begin
		if (guardBit | roundBit | stickyBit) begin 
			x_man <= x_man + 1;
			if (x_man == 24'hffffff) begin
				x_exp <= x_exp + 1; end
		end
            	state <= packing;
             end
 
   packing : begin
		n_sum[31] <= x_sign;
		n_sum[30:23] <= x_exp[7:0];
		n_sum[22:0] <= x_man[22:0];

		if (x_exp > 254) begin 
			n_sum[31] <= x_sign;
			n_sum[30:23] <= 255;
			n_sum[22:0] <= 0; end
            	state <= result;
             end

    result : begin
		sum <= n_sum;
           state <= start;
             end
endcase
end

  always @(*)
    ready = (state == start);
  
endmodule
