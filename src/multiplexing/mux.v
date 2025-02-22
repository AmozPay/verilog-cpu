
module mux2
  #(parameter BUS_WIDTH = 1) // Bus width of each input
  (
    output [BUS_WIDTH - 1:0] out, // Output bus
    input [BUS_WIDTH - 1:0] in0,
    input [BUS_WIDTH - 1:0] in1,
    input sel // Selector
  );

  wire [BUS_WIDTH - 1:0] and0, and1;
  wire not_sel;

  // Generate the NOT of the selector
  assign not_sel = ~sel;

  // AND gates for each input with the selector and its complement
  genvar i;
  generate
    for (i = 0; i < BUS_WIDTH; i = i + 1) begin : mux_logic
      assign and0[i] = in0[i] & not_sel;
      assign and1[i] = in1[i] & sel;
    end
  endgenerate

  // OR gate to combine the results
  assign out = and0 | and1;

endmodule

module mux4
  #(parameter BUS_WIDTH = 1) // Bus width of each input
  (
    output [BUS_WIDTH - 1:0] out, // Output bus
    input [BUS_WIDTH - 1:0] in0,
    input [BUS_WIDTH - 1:0] in1,
    input [BUS_WIDTH - 1:0] in2,
    input [BUS_WIDTH - 1:0] in3,
    input [1:0] sel // Selector
  );

  wire [BUS_WIDTH - 1 : 0] out_mux0, out_mux1;

  // AND gates for each input with the selectors and their complements

  mux2 #(.BUS_WIDTH(BUS_WIDTH)) mux0(
    out_mux0,
    in0,
    in1,
    sel[1]
  );

  mux2 #(.BUS_WIDTH(BUS_WIDTH)) mux1(
    out_mux1,
    in2,
    in3,
    sel[1]
  );

  mux2 #(.BUS_WIDTH(BUS_WIDTH)) mux2(
    out,
    out_mux0,
    out_mux1,
    sel[0]
  );


endmodule


module mux8
  #(parameter BUS_WIDTH = 1) // Bus width of each input
  (
    output [BUS_WIDTH - 1:0] out, // Output bus
    input [BUS_WIDTH - 1:0] in0,
    input [BUS_WIDTH - 1:0] in1,
    input [BUS_WIDTH - 1:0] in2,
    input [BUS_WIDTH - 1:0] in3,
    input [BUS_WIDTH - 1:0] in4,
    input [BUS_WIDTH - 1:0] in5,
    input [BUS_WIDTH - 1:0] in6,
    input [BUS_WIDTH - 1:0] in7,
    input [2:0] sel // Selector
  );

  wire [BUS_WIDTH - 1 : 0] out_mux0, out_mux1;

  mux4 #(.BUS_WIDTH(BUS_WIDTH)) mux0(
    out_mux0,
    in0,
    in1,
    in2,
    in3,
    {sel[2], sel[1]}
  );

  mux4 #(.BUS_WIDTH(BUS_WIDTH)) mux1(
    out_mux1,
    in4,
    in5,
    in6,
    in7,
    {sel[2], sel[1]}
  );

  mux2 #(.BUS_WIDTH(BUS_WIDTH)) mux2(
    out,
    out_mux0,
    out_mux1,
    sel[0]
  );
endmodule


module mux16
  #(parameter BUS_WIDTH = 1) // Bus width of each input
  (
    output [BUS_WIDTH - 1:0] out, // Output bus
    input [BUS_WIDTH - 1:0] in0,
    input [BUS_WIDTH - 1:0] in1,
    input [BUS_WIDTH - 1:0] in2,
    input [BUS_WIDTH - 1:0] in3,
    input [BUS_WIDTH - 1:0] in4,
    input [BUS_WIDTH - 1:0] in5,
    input [BUS_WIDTH - 1:0] in6,
    input [BUS_WIDTH - 1:0] in7,
    input [BUS_WIDTH - 1:0] in8,
    input [BUS_WIDTH - 1:0] in9,
    input [BUS_WIDTH - 1:0] in10,
    input [BUS_WIDTH - 1:0] in11,
    input [BUS_WIDTH - 1:0] in12,
    input [BUS_WIDTH - 1:0] in13,
    input [BUS_WIDTH - 1:0] in14,
    input [BUS_WIDTH - 1:0] in15,
    input [3:0] sel // Selector
  );


  wire [BUS_WIDTH - 1:0] out_mux0;
  wire [BUS_WIDTH - 1:0] out_mux1;
  // AND gates for each input with the selectors and their complements
  mux8 #(.BUS_WIDTH(BUS_WIDTH)) mux0(
    out_mux0,
    in0,
    in1,
    in2,
    in3,
    in4,
    in5,
    in6,
    in7,
    {sel[3], sel[2], sel[1]}
  );

  mux8 #(.BUS_WIDTH(BUS_WIDTH)) mux1(
    out_mux1,
    in8,
    in9,
    in10,
    in11,
    in12,
    in13,
    in14,
    in15,
    {sel[3], sel[2], sel[1]}
  );

  mux2 #(.BUS_WIDTH(BUS_WIDTH)) mux2(
    out,
    out_mux0,
    out_mux1,
    sel[0]
  );
endmodule