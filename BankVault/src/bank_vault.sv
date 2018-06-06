/////////////////////////////////////////////////////////////////////
// Design unit: bank_vault
//            :
// File name  : bank_vault.sv
//            :
// Description: Bank vault top level module
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Revision   : Version 1.0 11/15
/////////////////////////////////////////////////////////////////////

module bank_vault(input logic clock, n_reset, input logic [7:0] re_in, output logic [9:0] LEDG,	output logic [13:0] vaultSeg, output logic [13:0] stateSeg, output logic [6:0] dirSeg);

logic slow_clock, direction;
logic [4:0] v_code;
logic [7:0] lut_op;

assign v_code = lut_op[6:2];

counter c(.osc_clk(clock), .clock(slow_clock)); // produces slow clock
dir_decoder D(.clock(slow_clock), .vault_code(v_code), .direction(direction));
LUT l(.encoder_in(re_in), .vault_code(lut_op));
vault_controller VC(.clock(slow_clock), .n_reset(n_reset), .direction(direction), .vault_code(v_code), .led(LEDG), .vaultSeg(vaultSeg), .stateSeg(stateSeg), .dirSeg(dirSeg));

endmodule