
module or16(output out, input [15:0] inputs);
  wire [15:0] intermediate;

  genvar i;
  assign intermediate[0] = inputs[0];

  generate
    for (i = 1; i < 16; i = i + 1) begin: or_chain
      or or_gate(intermediate[i], intermediate[i - 1], inputs[i]);
    end
  endgenerate

  assign out = intermediate[15];
endmodule
