`include "src/boolean/p_and.v"

module tb_p_and;

  // Parameters
  parameter BUS_WIDTH = 4;
  parameter NB_INS = 3;

  // Inputs
  reg [BUS_WIDTH-1:0] in_buses [NB_INS-1:0];

  // Outputs
  wire [BUS_WIDTH-1:0] out_bus;

  // Instantiate the Unit Under Test (UUT)
  p_and #(
    .BUS_WIDTH(BUS_WIDTH),
    .NB_INS(NB_INS)
  ) uut (
    .out_bus(out_bus),
    .in_buses(in_buses)
  );

  initial begin
    // Initialize Inputs
    in_buses[0] = 4'b1101;
    in_buses[1] = 4'b1011;
    in_buses[2] = 4'b1111;

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

module tb_and_n;
  parameter NB_INS = 4;
  reg [NB_INS-1:0] ins;
  wire out;
  and_n #(.NB_INS(NB_INS)) and0(out, ins);


  integer i;
  initial begin
    $dumpfile("p_and.vcd");
    $dumpvars(0, tb_and_n);

    for (i = 0; i < NB_INS; i = i + 1) begin
        ins[i] = 0;
    end
    #10;
    for (i = 0; i < NB_INS; i = i + 1) begin
        ins[i] = 1;
        #10;
    end
  end
endmodule