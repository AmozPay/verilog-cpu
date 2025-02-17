
`include "src/and/andn.v"
`include "src/or/orn.v"


// A multiplexer with n selector pins and 2 ^ n data pins
module muxn
  #(parameter NB_SEL = 2)
  (output out, input [2 ** NB_SEL - 1:0] ins, input [NB_SEL - 1 :0] sel);
  wire [NB_SEL - 1:0] not_sel;
  wire [NB_SEL:0] and_inputs; // {ins[i], sel[0], sel[1], ...sel[NB_SEL - 1]} where sel[j] could also be !sel[j]
  wire [2 ** NB_SEL - 1:0] and_outputs;

  genvar j; // use j to iterate over each selector pin

  generate // generate NOT gate for each selector to get not_sel
    for (j = 0; j < NB_SEL; j = j + 1) begin: not_gen
      not (not_sel[j], sel[j]);
    end
  endgenerate


  genvar i; // use i to iterate over each data pin
  // Generating AND gate for each combination of selector and data pin
  generate
    for (i = 0; i < 2 ** NB_SEL; i = i + 1) begin: and_chain
      assign and_inputs[0] = ins[i];
      for (j = 0; j < NB_SEL; j = j + 1) begin: set_and_input
        // Determine if we should use sel or not_sel for eact AND gate pin
        assign and_inputs[j + 1] = i & (1 << j) ? sel[j] : not_sel[j];
      end
      andn #(.NB_IN(NB_SEL + 1)) and_gate(
        and_outputs[i],
        and_inputs
      );
    end
  endgenerate

  // Final output
  orn #(.NB_IN(2 ** NB_SEL)) or_gate(out, and_outputs);
endmodule

