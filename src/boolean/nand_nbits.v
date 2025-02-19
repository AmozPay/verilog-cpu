
// Perfom nand between two buses
module nand_nbits
#(parameter BUS_WIDTH = 1)
(output [BUS_WIDTH - 1:0] out_bus, input [BUS_WIDTH - 1:0] in_bus1, input [BUS_WIDTH - 1:0] in_bus2);

  genvar i;
  generate
    for (i = 0; i < BUS_WIDTH; i = i + 1) begin: assignment
      assign out_bus[i] = !(in_bus1[i] & in_bus2[i]);
    end
  endgenerate
endmodule
