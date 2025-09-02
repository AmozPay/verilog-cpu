`include "src/multiplexing/mux.v"
`include "src/alu/add.v"


module alu
#(parameter BUS_WIDTH = 16)
(
  output [BUS_WIDTH-1:0] out,
  output carry,
  output zr, /*zero*/
  output ng, /*negative*/
  input zx, /* set x to zero */
  input nx, /* negate x */
  input zy, // set y to zero
  input ny, // negate y
  input f, // out = f == 0 ? and(x, y) : add(x, y)
  input no, // negate output
  input [BUS_WIDTH-1:0] x,
  input [BUS_WIDTH-1:0] y
);
  wire [BUS_WIDTH-1:0] not_x;
  wire [BUS_WIDTH-1:0] not_y;
  wire [BUS_WIDTH-1:0] zero;
  wire [BUS_WIDTH-1:0] out_zx;
  wire [BUS_WIDTH-1:0] out_zy;
  wire [BUS_WIDTH-1:0] add_xy;
  wire [BUS_WIDTH-1:0] and_xy;
  wire [BUS_WIDTH-1:0] out_nx;
  wire [BUS_WIDTH-1:0] out_ny;
  wire [BUS_WIDTH-1:0] out_add;
  wire is_carried;
  wire [BUS_WIDTH-1:0] out_and;
  wire [BUS_WIDTH-1:0] out_f;
  wire [BUS_WIDTH-1:0] out_no;
  assign zero = x ^ x;

  mux2 #(.BUS_WIDTH(BUS_WIDTH)) zero_x(out_zx, x, zero, zx);
  mux2 #(.BUS_WIDTH(BUS_WIDTH)) zero_y(out_zy, y, zero, zy);

  assign not_x = ~out_zx;
  assign not_y = ~out_zy;

  mux2 #(.BUS_WIDTH(BUS_WIDTH)) negate_x(out_nx, out_zx, not_x, nx);
  mux2 #(.BUS_WIDTH(BUS_WIDTH)) negate_y(out_ny, out_zy, not_y, ny);


  add #(.BUS_WIDTH(BUS_WIDTH)) add(is_carried, out_add, out_nx, out_ny);
  assign out_and = out_nx & out_ny;

  mux2 #(.BUS_WIDTH(BUS_WIDTH)) apply_f(out_f, out_and, out_add, f);
  assign out_no = ~out_f;

  mux2 #(.BUS_WIDTH(BUS_WIDTH)) negate_o(out, out_f, out_no, no);

  assign carry = is_carried & f;
  assign zr = !(out | 0);
  assign ng = out[BUS_WIDTH-1];
endmodule
