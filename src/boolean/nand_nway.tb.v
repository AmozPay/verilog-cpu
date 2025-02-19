`include "src/boolean/nand_nway.v"

module tb_nand_nway;
  reg [7:0] ins_and8;
  wire out_and8;
  nand_nway #(.NB_IN(8)) nand8(out_and8, ins_and8);

  integer i;
  integer j;
  integer a;
  initial begin
    $dumpfile("nand_nway.vcd");
    $dumpvars(0, tb_nand_nway);
    for (i = 0; i < 2 ** 8; i = i + 1) begin: run_tick
      for (j = 0; j < 8; j = j + 1) begin: set_ins
        a = (i & (1 << j)) >> j;
        ins_and8[j] = a;
      end
      #10;
    end
    $finish;
  end
endmodule
