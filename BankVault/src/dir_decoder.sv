/////////////////////////////////////////////////////////////////////
// Design unit: dir decoder
//            :
// File name  : dir_decoder.sv
//            :
// Description: direction decoder
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Revision   : Version 1.0 11/15
/////////////////////////////////////////////////////////////////////

module dir_decoder (input logic clock,
					input logic [4:0] vault_code,
					output logic direction);

// SystemVerilog enumerated type for state machine states
enum {clockwise, anticlockwise} state;
logic [4:0] prev_code;

always_ff @(posedge clock)
  begin: seq 
  
	case (state)
	clockwise:
		if (vault_code == (prev_code - 1))
			state <= anticlockwise;
		else
			state <= clockwise;
	anticlockwise:
		if (vault_code == (prev_code + 1))
			state <= clockwise;
		else
			state <= anticlockwise;
    endcase
	 
	prev_code <= vault_code;
  end

always_comb
  begin: com
    case (state)
		clockwise: 
			direction = 1;
		anticlockwise:
			direction = 0;
      default: ;
    endcase
  end
  
endmodule
