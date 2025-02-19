
`include "src/boolean/and_nway.v"


// A demultiplexer with n selector pins and 2 ^ n output pins
module dmuxn
  #(parameter NB_SEL = 1)
  (output [2 ** NB_SEL - 1:0] outs, input in, input [NB_SEL - 1 :0] sel);
  wire [NB_SEL - 1:0] not_sel;
  wire [NB_SEL:0] and_inputs;

  genvar j; // use j to iterate over each selector pin

  generate // generate NOT gate for each selector to get not_sel
    for (j = 0; j < NB_SEL; j = j + 1) begin: not_gen
      not (not_sel[j], sel[j]);
    end
  endgenerate


  genvar i; // use i to iterate over each output pin
  // Generating AND gate for each combination of selector and output pin
  generate
    for (i = 0; i < 2 ** NB_SEL; i = i + 1) begin: and_chain
      assign and_inputs[0] = in;
      for (j = 0; j < NB_SEL; j = j + 1) begin: set_and_input
        // Determine if we should use sel or not_sel for eact AND gate pin
        assign and_inputs[j + 1] = i & (1 << j) ? sel[j] : not_sel[j];
      end
      and_nway #(.NB_IN(NB_SEL + 1)) and_gate(
        outs[i],
        and_inputs
      );
    end
  endgenerate
endmodule

