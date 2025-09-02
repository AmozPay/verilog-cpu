`include "src/sequential/pc.v"

// module tb_pc_load;
//   parameter BUS_WIDTH = 16;
//   reg inc, load, reset, clock;
//   reg [BUS_WIDTH - 1:0] in;
//   wire [BUS_WIDTH - 1:0] out;

//   pc #(.BUS_WIDTH(BUS_WIDTH)) pc0(out, reset, inc, load, in, clock);

//   initial begin
//     forever #5 clock = ~clock;
//   end

//   initial begin
//     $dumpfile("pc.vcd");
//     $dumpvars(0, tb_pc_load);
//     inc = 0; load = 0; reset = 0; clock = 1; in = 0;
//     reset = 1; #10;
//     reset = 0; #10;
//     load = 1; in = 5; #10;
//     in = 10; #10;
//     #10;
//     $finish;
//   end
// endmodule


module tb_pc;
  parameter BUS_WIDTH = 16;
  reg inc, load, reset, clock;
  reg [BUS_WIDTH - 1:0] in;
  wire [BUS_WIDTH - 1:0] out;

  pc #(.BUS_WIDTH(BUS_WIDTH)) pc0(out, reset, inc, load, in, clock);

  initial begin
    forever #5 clock = ~clock;
  end

  initial begin
    $dumpfile("pc.vcd");
    $dumpvars(0, tb_pc);
    inc = 0; load = 0; reset = 0; clock = 1; in = 0;
    reset = 1; #10;
    reset = 0; #10;
    inc = 1; #10;
    inc = 0; load = 1; in = 511; #10;
    inc = 1; load = 0; #10;
    #20;
    inc = 0; #10;
    inc = 0; load = 1; in = 4; #20;
    in = 8; #10;
    in = 16; #10;
    in = 18; #10;
    load = 0; #10;
    // inc = 0; load = 1; in = 5;#10;
    // inc = 0; load = 1; in = 0; #10;
    $finish;
  end
endmodule
