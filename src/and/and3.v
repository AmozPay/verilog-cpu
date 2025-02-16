
module and3(out, in1, in2, in3);
  input in1, in2, in3;
  output out;
  wire and1_out;

  and and1(and1_out, in1, in2);
  and and2(out, and1_out, in3);
endmodule

