module mux(in1,in2,sel,R);
  input in1,in2,sel;
  output R;
  wire not_sel;
  wire out_and1, out_and2;

  not not1(not_sel, sel);
  and and1(out_and1, not_sel, in1);
  and and2(out_and2, sel, in2);
  or (R, out_and1, out_and2);
endmodule
