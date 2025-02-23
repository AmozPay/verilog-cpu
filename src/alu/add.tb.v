`include "src/alu/add.v"

module tb_half_adder;
  reg a, b;
  wire sum, carry;

  half_adder hadd(sum, carry, a, b);

  initial begin
    $dumpfile("add.vcd");
    $dumpvars(0, tb_half_adder);
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
  end
endmodule

module tb_full_adder;
  reg a, b, c;
  wire sum, carry;

  full_adder fadd(sum, carry, a, b, c);

  initial begin
    $dumpfile("add.vcd");
    $dumpvars(0, tb_full_adder);
    a = 0; b = 0; c = 0; #10;
    a = 0; b = 0; c = 1; #10;
    a = 0; b = 1; c = 0; #10;
    a = 0; b = 1; c = 1; #10;

    a = 1; b = 0; c = 0; #10;
    a = 1; b = 0; c = 1; #10;
    a = 1; b = 1; c = 0; #10;
    a = 1; b = 1; c = 1; #10;
  end
endmodule

module tb_add;
  wire carry;
  wire [15:0] sum;
  reg [15:0] a;
  reg [15:0] b;

  add add(carry, sum, a, b);

  initial begin
    $dumpfile("add.vcd");
    $dumpvars(0, tb_add);

    a = 5; b = 5; #10;
    a = 1; b = 0; #10;
    a = 256; b = 44; #10;
    a = 65534; b = 1; #10;
    b = 2; #10;
    b = 3; #10;
    a = 65535; b = 65535; #10;
  end
endmodule