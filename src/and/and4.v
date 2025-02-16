module and4(out, in1, in2, in3, in4);
  input in1, in2, in3, in4;
  output out;
  wire and1_out;
  wire and2_out;

  and and1(and1_out, in1, in2);
  and and2(and2_out, and1_out, in3);
  and and3(out, and2_out, in4);
endmodule
