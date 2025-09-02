`include "src/boolean/p_nor.v"

module tb_p_nor;

  // Parameters
  parameter BUS_WIDTH = 4;
  parameter NB_INS = 3;

  // Inputs
  reg [BUS_WIDTH-1:0] in_buses [NB_INS-1:0];

  // Outputs
  wire [BUS_WIDTH-1:0] out_bus;

  // Instantiate the Unit Under Test (UUT)
  p_nor #(
    .BUS_WIDTH(BUS_WIDTH),
    .NB_INS(NB_INS)
  ) uut (
    .out_bus(out_bus),
    .in_buses(in_buses)
  );

  initial begin
    // Initialize Inputs
    in_buses[0] = 4'b1001;
    in_buses[1] = 4'b1011;
    in_buses[2] = 4'b1011;

    // Wait for some time and display the result
    #10;
    $display("in_buses[0] = %b", in_buses[0]);
    $display("in_buses[1] = %b", in_buses[1]);
    $display("in_buses[2] = %b", in_buses[2]);
    $display("out_bus = %b", out_bus);

    // Add more test cases if needed
    // ...

    // Finish simulation
    #10;
    $finish;
  end

endmodule
