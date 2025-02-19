
module nand_nway
#(parameter NB_IN = 2)
(output out, input [NB_IN - 1:0] inputs);
  wire [NB_IN - 1:0] intermediate;

  genvar i;
  assign intermediate[0] = inputs[0];

  generate
    for (i = 1; i < NB_IN; i = i + 1) begin: and_chain
      and and_gate(intermediate[i], intermediate[i - 1], inputs[i]);
    end
  endgenerate

  assign out = !intermediate[NB_IN - 1];
endmodule
