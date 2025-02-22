`include "src/boolean/p_or.v"

// p_nor: parametrized NOR
// Perform NOR operation between multiple buses
module p_nor
#(
  parameter BUS_WIDTH = 1,
  parameter NB_INS = 2
)
(output [BUS_WIDTH - 1:0] out_bus, input [BUS_WIDTH - 1:0] in_buses [NB_INS - 1 : 0]);

  wire [BUS_WIDTH - 1 : 0] intermediate;
  genvar i;

  p_or #(.NB_INS(NB_INS), .BUS_WIDTH(BUS_WIDTH)) p_or(intermediate, in_buses);
  generate
    for (i = 0; i < BUS_WIDTH; i = i + 1) begin: assign_output
      assign out_bus[i] = !intermediate[i];
    end
  endgenerate
endmodule
