
// p_and: parametrized AND
// Perform AND operation between multiple buses
module p_and
#(
  parameter BUS_WIDTH = 1,
  parameter NB_INS = 2
)
(
  output [BUS_WIDTH - 1:0] out_bus,
  input [BUS_WIDTH - 1:0] in_buses [NB_INS - 1 : 0]
);

  wire [BUS_WIDTH - 1 : 0] intermediate [NB_INS - 1:0];
  genvar i, j;

  generate
    for (i = 0; i < BUS_WIDTH; i = i + 1) begin: init_intermediate
      assign intermediate[0][i] = in_buses[0][i];
    end
    // Perform AND operation across all input buses
    for (i = 1; i < NB_INS; i = i + 1) begin: iter_over_ins
      for (j = 0; j < BUS_WIDTH; j = j + 1) begin: iter_over_bits
        assign intermediate[i][j] = intermediate[i - 1][j] & in_buses[i][j];
      end
    end
    // Assign the result to the output bus
    for (j = 0; j < BUS_WIDTH; j = j + 1) begin: assign_output
      assign out_bus[j] = intermediate[NB_INS - 1][j];
    end
  endgenerate
endmodule


module and_n #(parameter NB_INS = 2) (
  output out,
  input [NB_INS-1:0] ins
);
  wire [NB_INS - 1:0] intermediate;
  genvar i;

  assign intermediate[0] = ins[0];
  generate
    for (i = 1; i < NB_INS; i = i + 1) begin: iter_over_ins
        assign intermediate[i] = intermediate[i - 1] & ins[i];
    end
  endgenerate
  assign out = intermediate[NB_INS-1];
endmodule
