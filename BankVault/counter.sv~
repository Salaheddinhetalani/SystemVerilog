/////////////////////////////////////////////////////////////////////
// Design unit: counter
//            :
// File name  : counter.sv
//            :
// Description: counter used to produce a slow clock from
// 				the DE1-SoC internal clock (e.g 3.33MHz)
//            :
// Limitations: None
//            : 
// System     : SystemVerilog IEEE 1800-2005
//            :
// Revision   : Version 1.0 11/15
/////////////////////////////////////////////////////////////////////

module counter #(parameter n = 20)
(input logic osc_clk, output logic clock);
logic [n-1:0] count;
// declare an n-bit counter
// n=20: 2^20 * 1/3.33MHz = ~0.3 seconds
// n=18: 2^18 * 1/3.33MHz = ~1.2 seconds

always_ff @(posedge osc_clk) begin
 count <= count + 1;
end

// copy top bit to output - slow clock
assign clock = count[n-1];

endmodule