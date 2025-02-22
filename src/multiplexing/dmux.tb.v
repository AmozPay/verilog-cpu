`include "src/multiplexing/dmux.v"

module tb_dmux2;
  parameter BUS_WIDTH = 1;
  wire [BUS_WIDTH-1:0] out [1:0];
  reg [BUS_WIDTH-1:0] in;
  reg sel;

  dmux2 #(.BUS_WIDTH(BUS_WIDTH)) dmux2(out[0], out[1], in, sel);

  integer i;
  initial begin
    $dumpfile("dmux2.vcd");
    $dumpvars(0, tb_dmux2);

    for (i = 0; i < 2; i = i + 1) begin
      in = i;
      sel = i;
      #10;
    end
    #10;
  end
endmodule


module tb_dmux4;
  parameter BUS_WIDTH = 2;
  wire [BUS_WIDTH-1:0] out [3:0];
  reg [BUS_WIDTH-1:0] in;
  reg [1:0] sel;

  dmux4 #(.BUS_WIDTH(BUS_WIDTH)) dmux4(out[0], out[1], out[2], out[3], in, sel);

  integer i;
  initial begin
    $dumpfile("dmux4.vcd");
    $dumpvars(0, tb_dmux4);

    for (i = 0; i < 4; i = i + 1) begin
      in = i;
      sel = i;
      #10;
    end
    #10;
  end
endmodule

module tb_dmux8;
  parameter BUS_WIDTH = 3;
  wire [BUS_WIDTH-1:0] out [7:0];
  reg [BUS_WIDTH-1:0] in;
  reg [2:0] sel;

  dmux8 #(.BUS_WIDTH(BUS_WIDTH)) dmux8(
    out[0], out[1], out[2], out[3],
    out[4], out[5], out[6], out[7],
    in, sel
  );

  integer i;
  initial begin
    $dumpfile("dmux8.vcd");
    $dumpvars(0, tb_dmux8);

    for (i = 0; i < 8; i = i + 1) begin
      in = i;
      sel = i;
      #10;
    end
    #10;
  end
endmodule

module tb_dmux16;
  parameter BUS_WIDTH = 4;
  wire [BUS_WIDTH-1:0] out [15:0];
  reg [BUS_WIDTH-1:0] in;
  reg [3:0] sel;

  dmux16 #(.BUS_WIDTH(BUS_WIDTH)) dmux16(
    out[0], out[1], out[2], out[3],
    out[4], out[5], out[6], out[7],
    out[8], out[9], out[10], out[11],
    out[12], out[13], out[14], out[15],
    in, sel
  );

  integer i;
  initial begin
    $dumpfile("dmux16.vcd");
    $dumpvars(0, tb_dmux16);

    for (i = 0; i < 16; i = i + 1) begin
      sel = i;
      in = i;
      #10;
    end
    #10;
  end
endmodule