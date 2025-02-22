

// A demultiplexer with n selector pins and 2 ^ n output pins
module dmux2
  #(parameter BUS_WIDTH = 1) // Bus width of each input
  (
    output [BUS_WIDTH - 1:0] out0, // Output bus
    output [BUS_WIDTH - 1:0] out1,
    input [BUS_WIDTH - 1:0] in,
    input sel // Selector
  );
  // AND gates for each input with the selector and its complement
  genvar i;
  generate
      for (i = 0; i < BUS_WIDTH; i = i + 1) begin
        assign out0[i] = in[i] & ~sel;
        assign out1[i] = in[i] & sel;
      end
  endgenerate
endmodule

module dmux4
  #(parameter BUS_WIDTH = 1) // Bus width of each input
  (
    output [BUS_WIDTH - 1:0] out0, // Output bus
    output [BUS_WIDTH - 1:0] out1,
    output [BUS_WIDTH - 1:0] out2,
    output [BUS_WIDTH - 1:0] out3,
    input [BUS_WIDTH - 1:0] in,
    input [1:0] sel // Selector
  );

  wire [BUS_WIDTH - 1:0] dmux2_out0, dmux2_out1;

  // First level of demultiplexing
  dmux2 #(.BUS_WIDTH(BUS_WIDTH)) dmux2_0 (
    .out0(dmux2_out0),
    .out1(dmux2_out1),
    .in(in),
    .sel(sel[1])
  );

  // Second level of demultiplexing
  dmux2 #(.BUS_WIDTH(BUS_WIDTH)) dmux2_1 (
    .out0(out0),
    .out1(out1),
    .in(dmux2_out0),
    .sel(sel[0])
  );

  dmux2 #(.BUS_WIDTH(BUS_WIDTH)) dmux2_2 (
    .out0(out2),
    .out1(out3),
    .in(dmux2_out1),
    .sel(sel[0])
  );

endmodule

module dmux8
  #(parameter BUS_WIDTH = 1) // Bus width of each input
  (
    output [BUS_WIDTH - 1:0] out0, // Output bus
    output [BUS_WIDTH - 1:0] out1,
    output [BUS_WIDTH - 1:0] out2,
    output [BUS_WIDTH - 1:0] out3,
    output [BUS_WIDTH - 1:0] out4,
    output [BUS_WIDTH - 1:0] out5,
    output [BUS_WIDTH - 1:0] out6,
    output [BUS_WIDTH - 1:0] out7,
    input [BUS_WIDTH - 1:0] in,
    input [2:0] sel // Selector
  );

  wire [BUS_WIDTH - 1:0] dmux2_out0, dmux2_out1;

  // First level of demultiplexing
  dmux2 #(.BUS_WIDTH(BUS_WIDTH)) dmux2_0 (
    .out0(dmux2_out0),
    .out1(dmux2_out1),
    .in(in),
    .sel(sel[2])
  );

  // Second level of demultiplexing
  dmux4 #(.BUS_WIDTH(BUS_WIDTH)) dmux2_1 (
    out0,
    out1,
    out2,
    out3,
    dmux2_out0,
    {sel[1], sel[0]}
  );

  dmux4 #(.BUS_WIDTH(BUS_WIDTH)) dmux2_2 (
    out4,
    out5,
    out6,
    out7,
    dmux2_out1,
    {sel[1], sel[0]}
  );

endmodule



module dmux16
  #(parameter BUS_WIDTH = 1) // Bus width of each input
  (
    output [BUS_WIDTH - 1:0] out0, // Output bus
    output [BUS_WIDTH - 1:0] out1,
    output [BUS_WIDTH - 1:0] out2,
    output [BUS_WIDTH - 1:0] out3,
    output [BUS_WIDTH - 1:0] out4,
    output [BUS_WIDTH - 1:0] out5,
    output [BUS_WIDTH - 1:0] out6,
    output [BUS_WIDTH - 1:0] out7,
    output [BUS_WIDTH - 1:0] out8, // Output bus
    output [BUS_WIDTH - 1:0] out9,
    output [BUS_WIDTH - 1:0] out10,
    output [BUS_WIDTH - 1:0] out11,
    output [BUS_WIDTH - 1:0] out12,
    output [BUS_WIDTH - 1:0] out13,
    output [BUS_WIDTH - 1:0] out14,
    output [BUS_WIDTH - 1:0] out15,
    input [BUS_WIDTH - 1:0] in,
    input [3:0] sel // Selector
  );

  wire [BUS_WIDTH - 1:0] dmux2_out0, dmux2_out1;

  // First level of demultiplexing
  dmux2 #(.BUS_WIDTH(BUS_WIDTH)) dmux2 (
    .out0(dmux2_out0),
    .out1(dmux2_out1),
    .in(in),
    .sel(sel[3])
  );

  // Second level of demultiplexing
  dmux8 #(.BUS_WIDTH(BUS_WIDTH)) dmux8_1 (
    out0,
    out1,
    out2,
    out3,
    out4,
    out5,
    out6,
    out7,
    dmux2_out0,
    {sel[2], sel[1], sel[0]}
  );

  dmux8 #(.BUS_WIDTH(BUS_WIDTH)) dmux8_2 (
    out8,
    out9,
    out10,
    out11,
    out12,
    out13,
    out14,
    out15,
    dmux2_out1,
    {sel[2], sel[1], sel[0]}
  );

endmodule