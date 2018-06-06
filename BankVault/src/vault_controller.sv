/////////////////////////////////////////////////////////////////////
// Design unit: vault_controller
//            :
// File name  : vault_controller.sv
//            :
// Description: vault controller
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Revision   : Version 1.0 11/15
/////////////////////////////////////////////////////////////////////

module vault_controller (input logic clock, n_reset, direction, 
	input logic [4:0] vault_code,
	output logic [9:0]  led, 
	output logic [13:0] vaultSeg,
	output logic [13:0] stateSeg,
	output logic [6:0] dirSeg
 );

enum {locked, started, uptocomb1, downtocomb1, uptocomb2, unlocked, lock_reset} state, next_state;

always_ff @(posedge clock, negedge n_reset) 
  begin: seq 
	if (!n_reset) 
	 state <= locked; 
	else 
         state <= next_state; 
  end

always_comb
  begin: nxtState
	
	next_state = state;
	unique case (state)
		locked : begin
			if (direction) 
				next_state = locked;
			else if (vault_code > 0)
				next_state = locked;
			else if (vault_code == 0)
				next_state = started;
			else 
				next_state = locked;
			 end
		started : begin
			if (!direction) 
				next_state = started;
			else if (vault_code == 0)
				next_state = started;
			else if (vault_code > 0)
				next_state = uptocomb1;
			else 
				next_state = started;
			  end
		uptocomb1 : begin
			if (!direction) 
				next_state = locked;
			else if (vault_code > 7)
				next_state = locked;
			else if (vault_code < 7)
				next_state = uptocomb1;
			else
				next_state = downtocomb1;
			   end
		downtocomb1 : begin
			if (direction) 
				next_state = downtocomb1;
			else if (vault_code > 3)
				next_state = downtocomb1;
			else if (vault_code < 3)
				next_state = locked;
			else
				next_state = uptocomb2;
			   end
		uptocomb2 : begin
			if (!direction) 
				next_state = uptocomb2;
			else if (vault_code > 22)
				next_state = locked;
			else if (vault_code < 22)
				next_state = uptocomb2;
			else
				next_state = unlocked;
			   end
		unlocked : begin
			if (direction) 
				next_state = unlocked;
			else 
				next_state = lock_reset;
			   end
		lock_reset : begin
			if (direction) 
				next_state = lock_reset;
			else if (vault_code > 0)
				next_state = lock_reset;
			else if (vault_code == 0)
				next_state = locked;
			else
				next_state = lock_reset;
			     end
		default: ;
	endcase
  end


always_comb	   // always_comb - combinational logic for output signals; implicit sensitivity list
  begin: com
  
	// leds are used to display information about the controller's operation
	led[0] = (state == locked);     // vault locked
	led[1] = (state == started);    // vault unlocked
	led[2] = (state == uptocomb1);  // rotating up towards combination
	led[3] = (state == unlocked);   // in process of resetting
	led[4] = direction;		//direction of turning RE
	led[5] = vault_code[0];     	// vault code
	led[6] = vault_code[1];         // vault code
	led[7] = vault_code[2];         // vault code
      	led[8] = vault_code[3];         // vault code
	led[9] = vault_code[4];    	// vault code
	
	if (state == locked)
		stateSeg = 14'b10001111000000;
	else if (state == started)
		stateSeg = 14'b00100101000111;
	else if (state == uptocomb1)
		stateSeg = 14'b10000011111000;
	else if (state == downtocomb1)
		stateSeg = 14'b01000010110000;
	else if (state == uptocomb2)
		stateSeg = 14'b10000010100100;	
	else if (state == unlocked)
		stateSeg = 14'b10000011000111;
	else if (state == lock_reset)
		stateSeg = 14'b10001110101111;
	else 
		stateSeg = 14'b11111111111111;	
  end
  
  always_comb
  unique casez (vault_code)
    	5'b00000 : vaultSeg = 14'b10000001000000;
    	5'b00001 : vaultSeg = 14'b10000001111001;
	5'b00010 : vaultSeg = 14'b10000000100100;
	5'b00011 : vaultSeg = 14'b10000000110000;
	5'b00100 : vaultSeg = 14'b10000000011001;
	5'b00101 : vaultSeg = 14'b10000000010010;
	5'b00110 : vaultSeg = 14'b10000000000010;
	5'b00111 : vaultSeg = 14'b10000001111000;
	5'b01000 : vaultSeg = 14'b10000000000000;
	5'b01001 : vaultSeg = 14'b10000000010000;
	5'b01010 : vaultSeg = 14'b11110011000000;
	5'b01011 : vaultSeg = 14'b11110011111001;
	5'b01100 : vaultSeg = 14'b11110010100100;
	5'b01101 : vaultSeg = 14'b11110010110000;
	5'b01110 : vaultSeg = 14'b11110010011001;
	5'b01111 : vaultSeg = 14'b11110010010010;
	5'b10000 : vaultSeg = 14'b11110010000010;
	5'b10001 : vaultSeg = 14'b11110011111000;
	5'b10010 : vaultSeg = 14'b11110010000000;
	5'b10011 : vaultSeg = 14'b11110010010000;
	5'b10100 : vaultSeg = 14'b01001001000000;
	5'b10101 : vaultSeg = 14'b01001001111001;
	5'b10110 : vaultSeg = 14'b01001000100100;
	5'b10111 : vaultSeg = 14'b01001000110000;
	5'b11000 : vaultSeg = 14'b01001000011001;
	5'b11001 : vaultSeg = 14'b01001000010010;
	5'b11010 : vaultSeg = 14'b01001000000010;
	5'b11011 : vaultSeg = 14'b01001001111000;
	5'b11100 : vaultSeg = 14'b01001000000000;
	5'b11101 : vaultSeg = 14'b01001000010000;
	5'b11110 : vaultSeg = 14'b01100001000000;
	5'b11111 : vaultSeg = 14'b01100001111001;
	
    default  : vaultSeg = 14'b11111111111111;
  endcase
  
  always_comb
  unique casez (direction)
    1'b0 : dirSeg = 7'b1000001;
    1'b1 : dirSeg = 7'b1000110;
    default  : dirSeg = 7'b1111111;
  endcase

endmodule
