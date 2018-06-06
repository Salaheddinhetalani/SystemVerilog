/////////////////////////////////////////////////////////////////////
// Design unit: encoder
//            :
// File name  : encoder.sv
//            :
// Description: Look-up table for decoding the rotary encoder output
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Revision   : Version 1.0 11/15
/////////////////////////////////////////////////////////////////////

module LUT (input logic [7:0] encoder_in, output logic [7:0] vault_code);

always_comb
	begin
	vault_code = 8'd0;
	
	case(encoder_in)
		8'b01111111: vault_code = 8'd0; //8'b0|00000|00 --> 0
		8'b00111111: vault_code = 8'd1; //8'b0|00000|01 --> 0
		8'b00111110: vault_code = 8'd2; //8'b0|00000|10 --> 0
		8'b00111010: vault_code = 8'd3; //8'b0|00000|11 --> 0

		8'b00111000: vault_code = 8'd4; //8'b0|00001|00 --> 1
		8'b10111000: vault_code = 8'd5; //8'b0|00001|01 --> 1
		8'b10011000: vault_code = 8'd6; //8'b0|00001|10 --> 1
		8'b00011000: vault_code = 8'd7; //8'b0|00001|11 --> 1

		8'b00001000: vault_code = 8'd8; //8'b0|00010|00 --> 2
		8'b01001000: vault_code = 8'd9; //8'b0|00010|01 --> 2
		8'b01001001: vault_code = 8'd10;//8'b0|00010|10 --> 2
		8'b01001101: vault_code = 8'd11;//8'b0|00010|11 --> 2

		8'b01001111: vault_code = 8'd12;//8'b0|00011|00 --> 3
		8'b00001111: vault_code = 8'd13;//8'b0|00011|01 --> 3
		8'b00101111: vault_code = 8'd14;//8'b0|00011|10 --> 3
		8'b10101111: vault_code = 8'd15;//8'b0|00011|11 --> 3

		8'b10111111: vault_code = 8'd16;//8'b0|00100|00 --> 4
		8'b10011111: vault_code = 8'd17;//8'b0|00100|01 --> 4
		8'b00011111: vault_code = 8'd18;//8'b0|00100|10 --> 4
		8'b00011101: vault_code = 8'd19;//8'b0|00100|11 --> 4

		8'b00011100: vault_code = 8'd20;//8'b0|00101|00 --> 5
		8'b01011100: vault_code = 8'd21;//8'b0|00101|01 --> 5
		8'b01001100: vault_code = 8'd22;//8'b0|00101|10 --> 5
		8'b00001100: vault_code = 8'd23;//8'b0|00101|11 --> 5

		8'b00000100: vault_code = 8'd24;//8'b0|00110|00 --> 6
		8'b00100100: vault_code = 8'd25;
		8'b10100100: vault_code = 8'd26;
		8'b10100110: vault_code = 8'd27;

		8'b10100111: vault_code = 8'd28;//8'b0|00111|00 --> 7
		8'b10000111: vault_code = 8'd29;
		8'b10010111: vault_code = 8'd30;
		8'b11010111: vault_code = 8'd31;

		8'b11011111: vault_code = 8'd32;//8'b0|01000|00 --> 8
		8'b11001111: vault_code = 8'd33;
		8'b10001111: vault_code = 8'd34;
		8'b10001110: vault_code = 8'd35;

		8'b00001110: vault_code = 8'd36;//8'b0|01001|00 --> 9
		8'b00101110: vault_code = 8'd37;
		8'b00100110: vault_code = 8'd38;
		8'b00000110: vault_code = 8'd39;

		8'b00000010: vault_code = 8'd40;//8'b0|01010|00 --> 10
		8'b00010010: vault_code = 8'd41;
		8'b01010010: vault_code = 8'd42;
		8'b01010011: vault_code = 8'd43;

		8'b11010011: vault_code = 8'd44;//8'b0|01011|00 --> 11
		8'b11000011: vault_code = 8'd45;
		8'b11001011: vault_code = 8'd46;
		8'b11101011: vault_code = 8'd47;

		8'b11101111: vault_code = 8'd48;//8'b0|01100|00 --> 12
		8'b11100111: vault_code = 8'd49;
		8'b11000111: vault_code = 8'd50;
		8'b01000111: vault_code = 8'd51;

		8'b00000111: vault_code = 8'd52;//8'b0|01101|00 --> 13
		8'b00010111: vault_code = 8'd53;
		8'b00010011: vault_code = 8'd54;
		8'b00000011: vault_code = 8'd55;

		8'b00000001: vault_code = 8'd56;//8'b0|01110|00 --> 14
		8'b00001001: vault_code = 8'd57;
		8'b00101001: vault_code = 8'd58;
		8'b10101001: vault_code = 8'd59;

		8'b11101001: vault_code = 8'd60;//8'b0|01111|00 --> 15
		8'b11100001: vault_code = 8'd61;
		8'b11100101: vault_code = 8'd62;
		8'b11110101: vault_code = 8'd63;

		8'b11110111: vault_code = 8'd64;//8'b0|10000|00 --> 16
		8'b11110011: vault_code = 8'd65;
		8'b11100011: vault_code = 8'd66;
		8'b10100011: vault_code = 8'd67;

		8'b10000011: vault_code = 8'd68;//8'b0|10001|00 --> 17
		8'b10001011: vault_code = 8'd69;
		8'b10001001: vault_code = 8'd70;
		8'b10000001: vault_code = 8'd71;

		8'b10000000: vault_code = 8'd72;//8'b0|10010|00 --> 18
		8'b10000100: vault_code = 8'd73;
		8'b10010100: vault_code = 8'd74;
		8'b11010100: vault_code = 8'd75;

		8'b11110100: vault_code = 8'd76;//8'b0|10011|00 --> 19
		8'b11110000: vault_code = 8'd77;
		8'b11110010: vault_code = 8'd78;
		8'b11111010: vault_code = 8'd79;

		8'b11111011: vault_code = 8'd80;//8'b0|10100|00 --> 20
		8'b11111001: vault_code = 8'd81;
		8'b11110001: vault_code = 8'd82;
		8'b11010001: vault_code = 8'd83;

		8'b11000001: vault_code = 8'd84;//8'b0|10101|00 --> 21
		8'b11000101: vault_code = 8'd85;
		8'b11000100: vault_code = 8'd86;
		8'b11000000: vault_code = 8'd87;

		8'b01000000: vault_code = 8'd88;//8'b0|10110|00 --> 22
		8'b01000010: vault_code = 8'd89;
		8'b01001010: vault_code = 8'd90;
		8'b01101010: vault_code = 8'd91;

		8'b01111010: vault_code = 8'd92;//8'b0|10111|00 --> 23
		8'b01111000: vault_code = 8'd93;
		8'b01111001: vault_code = 8'd94;
		8'b01111101: vault_code = 8'd95;

		8'b11111101: vault_code = 8'd96;// --> 24
		8'b11111100: vault_code = 8'd97;
		8'b11111000: vault_code = 8'd98;
		8'b11101000: vault_code = 8'd99;

		8'b11100000: vault_code = 8'd100;// --> 25
		8'b11100010: vault_code = 8'd101;
		8'b01100010: vault_code = 8'd102;
		8'b01100000: vault_code = 8'd103;

		8'b00100000: vault_code = 8'd104;// --> 26
		8'b00100001: vault_code = 8'd105;
		8'b00100101: vault_code = 8'd106;
		8'b00110101: vault_code = 8'd107;

		8'b00111101: vault_code = 8'd108;// --> 27
		8'b00111100: vault_code = 8'd109;
		8'b10111100: vault_code = 8'd110;
		8'b10111110: vault_code = 8'd111;

		8'b11111110: vault_code = 8'd112;// --> 28
		8'b01111110: vault_code = 8'd113;
		8'b01111100: vault_code = 8'd114;
		8'b01110100: vault_code = 8'd115;

		8'b01110000: vault_code = 8'd116;// --> 29
		8'b01110001: vault_code = 8'd117;
		8'b00110001: vault_code = 8'd118;
		8'b00110000: vault_code = 8'd119;

		8'b00010000: vault_code = 8'd120;// --> 30
		8'b10010000: vault_code = 8'd121;
		8'b10010010: vault_code = 8'd122;
		8'b10011010: vault_code = 8'd123;

		8'b10011110: vault_code = 8'd124;// --> 31
		8'b00011110: vault_code = 8'd125;
		8'b01011110: vault_code = 8'd126;
		8'b01011111: vault_code = 8'd127;
		default ;
	endcase
	end
endmodule
