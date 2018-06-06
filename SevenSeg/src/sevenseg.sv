/////////////////////////////////////////////////////////////////////
// Design unit: sevenseg
//            :
// File name  : sevenseg.sv
//            :
// Description: Seven segment decoder described as ROM
//            : Active Low outputs
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Salaheddin Hetalani
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO18 2NU, UK
//            : sh9n17@ecs.soton.ac.uk
//
// Revision   : Version 1.0 30/10/17
/////////////////////////////////////////////////////////////////////

module sevenseg(output logic [6:0] data, 
                input logic [3:0] address);

always_comb
  unique casez (address)
    4'b0000 : data = 7'b1000000;
    4'b0001 : data = 7'b1111001;
    4'b0010 : data = 7'b0100100;
    4'b0011 : data = 7'b0110000;
    4'b0100 : data = 7'b0011001;
    4'b0101 : data = 7'b0010010;
    4'b0110 : data = 7'b0000010;
    4'b0111 : data = 7'b1111000;
    4'b1000 : data = 7'b0000000;
    4'b1001 : data = 7'b0010000;
    4'b101?, 
    4'b11?? : data = 7'b0000110;
    default : data = 7'b1111111;
  endcase
endmodule

