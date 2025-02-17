
`include "src/and/and4.v"
`include "src/or/or8.v"

module mux8(output out, input [7:0] ins, input [2:0] sel);
  wire [2:0] not_sel;
  wire [7:0] out_and;

  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin: and_chain
      and4 and_gate(
        out_and[i],
        ins[i],
        i & 3'b100 ? sel[2] : not_sel[2],
        i & 2'b10 ? sel[1] : not_sel[1],
        i & 1'b1 ? sel[0] : not_sel[0]
      );
    end
  endgenerate
  or8 or_gate(out, out_and);
endmodule
