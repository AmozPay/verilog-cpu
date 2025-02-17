`include "src/or/or4.v"
`include "src/and/and3.v"

module mux4(out, in1, in2, in3, in4, sel1, sel2);
  input in1, in2, in3, in4, sel1, sel2;
  output out;
  wire not_sel1;
  wire not_sel2;
  wire out_and1, out_and2, out_and3, out_and4;

  not not1(not_sel1, sel1);
  not not2(not_sel2, sel2);
  and3 and31(.out(out_and1), .in1(not_sel1), .in2(not_sel2), .in3(in1));
  and3 and32(.out(out_and2), .in1(sel1), .in2(not_sel2), .in3(in2));
  and3 and33(.out(out_and3), .in1(not_sel1), .in2(sel2), .in3(in3));
  and3 and34(.out(out_and4), .in1(sel1), .in2(sel2), .in3(in4));
  or4 or4l(.out(out), .in1(out_and1), .in2(out_and2), .in3(out_and3), .in4(out_and4));
endmodule
