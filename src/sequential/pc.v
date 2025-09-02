`include "src/alu/add.v"
`include "src/sequential/flipflop.v"

module pc #(parameter BUS_WIDTH = 16)
(
  output reg [BUS_WIDTH - 1:0] out,
  input reset,
  input inc,
  input load,
  input [BUS_WIDTH - 1:0] in,
  input clock
);
  wire [BUS_WIDTH - 1:0] zero;
  wire [BUS_WIDTH - 1:0] incremented;
  wire [BUS_WIDTH - 1:0] input_flipflop;
  wire [1:0] sel;
  wire load_dff;


  assign sel[0] = reset | (inc & ~load);
  assign sel[1] = ~reset & (load | inc);
  assign zero = 0;

  assign load_dff = inc | reset | load;

  inc #(.BUS_WIDTH(BUS_WIDTH)) inc0(incremented, out);
  mux4 #(.BUS_WIDTH(BUS_WIDTH)) mux0(input_flipflop, out, zero, in, incremented, sel);

  // always @(posedge clock) begin
  //   if (load) out <= input_flipflop;
  // end
  d_flipflop #(.BUS_WIDTH(BUS_WIDTH)) dff0(out, input_flipflop, load_dff, clock);
endmodule
