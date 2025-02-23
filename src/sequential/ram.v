`include "src/sequential/flipflop.v"
`include "src/multiplexing/dmux.v"


module p_ram #(parameter BIT_WIDTH = 1, parameter SEL_WIDTH = 3)
(
  output wire [BIT_WIDTH-1:0] out [2 ** SEL_WIDTH -1:0],
  input [BIT_WIDTH-1:0] in,
  input [SEL_WIDTH-1:0] address,
  input load,
  input clock,
  input reset
);

  wire [2 ** SEL_WIDTH -1:0] out_dmux;
  wire [2 ** SEL_WIDTH -1:0] load_or_reset;
  dmux1bit #(.NB_SEL(SEL_WIDTH)) dmux(out_dmux, address, load);

  genvar i;
  generate
    for (i = 0; i < 2 ** SEL_WIDTH; i = i + 1) begin
      assign load_or_reset[i] = out_dmux[i] | reset;
      d_flipflop #(.BUS_WIDTH(BIT_WIDTH)) dff(out[i], in, load_or_reset[i], clock);
    end
  endgenerate
endmodule

module ram8 #(parameter BIT_WIDTH = 1)
(
  output wire [BIT_WIDTH-1:0] out [7:0],
  input [BIT_WIDTH-1:0] in,
  input [2:0] address,
  input load,
  input clock,
  input reset
);
  p_ram #(.BIT_WIDTH(BIT_WIDTH), .SEL_WIDTH(3)) ram(out, in, address, load, clock, reset);

endmodule

module ram64 #(parameter BIT_WIDTH = 1)
(
  output wire [BIT_WIDTH-1:0] out [63:0],
  input [BIT_WIDTH-1:0] in,
  input [5:0] address,
  input load,
  input clock,
  input reset
);
  p_ram #(.BIT_WIDTH(BIT_WIDTH), .SEL_WIDTH(6)) ram(out, in, address, load, clock, reset);

endmodule

module ram512 #(parameter BIT_WIDTH = 1)
(
  output wire [BIT_WIDTH-1:0] out [511:0],
  input [BIT_WIDTH-1:0] in,
  input [8:0] address,
  input load,
  input clock,
  input reset
);
  p_ram #(.BIT_WIDTH(BIT_WIDTH), .SEL_WIDTH(9)) ram(out, in, address, load, clock, reset);

endmodule

module ram4K #(parameter BIT_WIDTH = 1)
(
  output wire [BIT_WIDTH-1:0] out [4095:0],
  input [BIT_WIDTH-1:0] in,
  input [11:0] address,
  input load,
  input clock,
  input reset
);
  p_ram #(.BIT_WIDTH(BIT_WIDTH), .SEL_WIDTH(12)) ram(out, in, address, load, clock, reset);

endmodule

module ram16K #(parameter BIT_WIDTH = 1)
(
  output wire [BIT_WIDTH-1:0] out [4096 * 4 - 1:0],
  input [BIT_WIDTH-1:0] in,
  input [13:0] address,
  input load,
  input clock,
  input reset
);
  p_ram #(.BIT_WIDTH(BIT_WIDTH), .SEL_WIDTH(14)) ram(out, in, address, load, clock, reset);

endmodule
