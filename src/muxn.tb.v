
`include "src/muxn.v"

module tb_muxn;
    reg [2:0] sel_mux8;
    reg [7:0] ins_mux8;
    wire out_mux8;

    muxn #(.NB_SEL(3)) mux8(out_mux8, ins_mux8, sel_mux8);
    integer i, j;
    initial begin
      $dumpfile("muxn.vcp");
      $dumpvars(0, tb_muxn);
      for (i = 0; i < 2 ** (3 + 8); i = i + 1) begin: iter_over_combinations
        for (j = 0; j < 3; j = j + 1) begin: set_sel
            sel_mux8[j] = ((i % (2 ** 3)) >> j) & 1;
        end
        for (j = 0; j < 8; j = j + 1) begin: set_ins
            ins_mux8[j] = ((i % (2 ** 8)) >> j) & 1;
        end
        #1;
      end
    end
endmodule