/////////////////////////////////////////////////////////////////////
// Design unit: vault_testbench
//            :
// File name  : vault_testbench.sv
//            :
// Description: testbench for bank vault
//            : DO NOT attempt to synthesise this model!!!
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Revision   : Version 1.0 11/15
/////////////////////////////////////////////////////////////////////
module test_vault;
  
logic clock, n_reset;
logic [7:0] re_in;
logic [9:0] LEDG;

initial  // 50MHz clock 
 begin
    clock = '0;
    forever #10ns clock = ~clock;
 end

initial 
  begin
	n_reset = '0; // assert reset

	re_in = 8'b01111111;
	
	#5ns  n_reset = '1; // cancel reset before 1st clock tick

	#50ns re_in = 8'b01111111; //0
	#50ns re_in = 8'b00111000; //1
	#50ns re_in = 8'b01111111; //0
	#50ns re_in = 8'b00111000; //1
	#50ns re_in = 8'b00001000; //2
	#50ns re_in = 8'b01001111; //3
	#50ns re_in = 8'b10111111; //4
	#50ns re_in = 8'b00011100; //5
	#50ns re_in = 8'b00000100; //6
	#50ns re_in = 8'b10100111; //7
	#20ns re_in = 8'b00000100; //6
	#50ns re_in = 8'b00011100; //5
	#50ns re_in = 8'b10111111; //4
	#50ns re_in = 8'b01001111; //3
	#20ns re_in = 8'b10111111; //4
	#50ns re_in = 8'b00011100; //5
	#50ns re_in = 8'b00000100; //6
	#50ns re_in = 8'b10100111; //7
	#50ns re_in = 8'b11011111; //8
	#50ns re_in = 8'b00001110; //9
	#50ns re_in = 8'b00000010; //10
	#50ns re_in = 8'b11010011; //11
	#50ns re_in = 8'b11101111; //12
	#50ns re_in = 8'b00000111; //13
	#50ns re_in = 8'b00000001; //14
	#50ns re_in = 8'b11101001; //15
	#50ns re_in = 8'b11110111; //16
	#50ns re_in = 8'b10000011; //17
	#50ns re_in = 8'b10000000; //18
	#50ns re_in = 8'b11110100; //19
	#50ns re_in = 8'b11111011; //20
	#50ns re_in = 8'b11000001; //21
	#50ns re_in = 8'b01000000; //22
	#50ns re_in = 8'b01111010; //23	

	
	#50ns n_reset = '0;
	#10ns  n_reset = '1;
	
	#50ns re_in = 8'b01111111; //0


  end
  
 bank_vault bv0 (.*); // bank vault hardware - synthesisable module


endmodule

