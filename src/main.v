`include "src/mux/mux4.v"

module main();
  reg [1:0] sel;
  reg [3:0] in;
  wire out;

  mux4 mux(in[0], in[1], in[2], in[3], sel[0], sel[1], out);
  initial begin
    in[0] = 0;
    in[1] = 0;
    in[2] = 0;
    in[3] = 0;
    sel[0] = 1;
    sel[1] = 1;
    #10
    $display("Hello World %b", out);
  end

endmodule

// --------------------------------------------------------------
