`include "src/sequential/flipflop.v"

module tb_sr_flipflop;
  reg s, r;
  wire q, qb;

  sr_flipflop sr(.q(q), .qb(qb), .r(r), .s(s));

  initial begin
    $dumpfile("flipflop.vcd");
    $dumpvars(0, tb_sr_flipflop);
    s = 0; r = 0; #10;
    s = 0; r = 1; #10;
    r = 0; #10;
    s = 1; #10;
    s = 0; #10;
    r = 1; #10;
  end
endmodule

module tb_d_flipflop;
  parameter BUS_WIDTH = 8;

  reg [BUS_WIDTH - 1:0] in;
  wire [BUS_WIDTH-1:0] out;
  reg load, clock;

  d_flipflop #(.BUS_WIDTH(BUS_WIDTH)) dff(out, in, load, clock);

  initial begin
    forever #5 clock = ~clock;
  end

  initial begin
    $dumpfile("flipflop.vcd");
    $dumpvars(0, tb_d_flipflop);
    clock = 1;
    in = 0; load = 0; #10;
    load = 1; #10;
    load = 0; #10;
    in = 9; load = 1; #10;
    load = 0; #10;
    in = 0; #10;
    load = 1; in = 15; #10;
    load = 0; #10;
    $finish;
  end
endmodule
