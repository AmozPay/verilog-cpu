

// ------------------------ demultiplexers.v ----------------------------

module dmux(in,sel,out1,out2);
  input in, sel;
  output out1, out2;
  wire not_sel;

  not not1(not_sel, sel);
  and and1(out1, not_sel, in);
  and and2(out2, sel, in);
endmodule

// --------------------------------------------------------------
