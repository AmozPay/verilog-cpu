`include "src/alu/alu.v"


module tb_alu;
  parameter BUS_WIDTH = 16;
  wire [BUS_WIDTH-1:0] out;
  wire carry, zr, ng;
  reg zx, nx, zy, ny, f, no;
  reg [BUS_WIDTH-1:0] x;
  reg [BUS_WIDTH-1:0] y;

  alu #(.BUS_WIDTH(BUS_WIDTH)) alu(
    out,
    carry,
    zr,
    ng,
    zx,
    nx,
    zy,
    ny,
    f,
    no,
    x,
    y
  );

  initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, tb_alu);
    x = 0; y = 0; zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0; #10;
    x = 1; y = 3; #10; // should do and(x, y) = 1;
    f = 1; #10; // should do x + y = 4 or 0b100;
    no = 1; #10; // should negate output = 0b1111111111111011 or 0xfffb;
    nx = 1; ny = 1; f = 0; no = 0; #10; // should do 0b1111111111111110 & 0b1111111111111101 = 0b1111111111111100 or 0xfffc
    x = 2; y = -1; f = 1; no = 0; nx = 0; ny = 0; zx = 0; zy = 0; #10;
    x = 50; y = -40; #10;
  end
endmodule
