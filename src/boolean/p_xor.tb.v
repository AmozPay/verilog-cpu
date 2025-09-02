`include "src/boolean/p_xor.v"

// Perform XOR between two buses
module tb_p_xor;

  // Parameters
  parameter BUS_WIDTH = 4;

  // Inputs
  reg [BUS_WIDTH-1:0] in_bus1;
  reg [BUS_WIDTH-1:0] in_bus2;

  // Outputs
  wire [BUS_WIDTH-1:0] out_bus;

  // Instantiate the Unit Under Test (UUT)
  p_xor #(
    .BUS_WIDTH(BUS_WIDTH)
  ) uut (
    .out_bus(out_bus),
    .in_bus1(in_bus1),
    .in_bus2(in_bus2)
  );

  initial begin
    // Initialize Inputs
    in_bus1 = 4'b1101;
    in_bus2 = 4'b1011;

    // Wait for some time and display the result
    #10;
    $display("in_bus1 = %b", in_bus1);
    $display("in_bus2 = %b", in_bus2);
    $display("out_bus = %b", out_bus);

    // Add more test cases if needed
    // ...

    // Finish simulation
    #10;
    $finish;
  end

endmodule
