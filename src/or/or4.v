module or4(output out, input in1, input in2, input in3, input in4);
  wire intermediate1, intermediate2;

  or or1(intermediate1, in1, in2);
  or or2(intermediate2, intermediate1, in3);
  or or3(out, intermediate2, in4);
endmodule
