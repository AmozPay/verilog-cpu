
module and8(output out, input [7:0] inputs);
  wire [7:0] intermediate;

  genvar i;
  assign intermediate[0] = inputs[0];

  generate
    for (i = 1; i < 8; i = i + 1) begin: and_chain
      and and_gate(intermediate[i], intermediate[i - 1], inputs[i]);
    end
  endgenerate

  assign out = intermediate[7];
endmodule
