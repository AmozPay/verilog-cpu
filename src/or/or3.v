module or3(output out, input in1, input in2, input in3);
  wire intermediate;

  or or1(intermediate, in1, in2);
  or or2(out, intermediate, in3);
endmodule