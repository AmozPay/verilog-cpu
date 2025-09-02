`include "src/multiplexing/mux.v"

module sr_flipflop(
  output q,
  output qb,
  input r,
  input s
);

  wire out_xor0, out_xor1;

  assign out_xor0 = r ^ out_xor1;
  assign out_xor1 = s ^ out_xor0;

  assign q = out_xor0;
  assign qb = out_xor1;
endmodule


module d_flipflop
#(parameter BUS_WIDTH = 1)
(
  output reg [BUS_WIDTH - 1:0] out,
  input [BUS_WIDTH - 1:0] in,
  input load,
  input clock
);
  always @(posedge clock) begin
    if (load)
      out <= in;
  end
endmodule
