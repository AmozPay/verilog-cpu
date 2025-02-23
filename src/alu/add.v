
module half_adder(output sum, output carry, input a, input b);
  assign sum = a ^ b;
  assign carry = a & b;
endmodule

module full_adder(output sum, output carry, input a, input b, input c);
  assign sum = a ^ b ^ c;
  assign carry = (a & (b|c)) | (b&c);
endmodule

module add
#(parameter BUS_WIDTH = 16)
(output carry, output [BUS_WIDTH-1:0] sum, input [BUS_WIDTH-1:0] a, input [BUS_WIDTH-1:0] b);
  wire [BUS_WIDTH-1:0] carries;

  genvar i;
  generate
    half_adder hadd(sum[0], carries[0], a[0], b[0]);
    for (i = 1; i < BUS_WIDTH; i = i + 1) begin
      full_adder fadd(sum[i], carries[i], a[i], b[i], carries[i - 1]);
    end
  endgenerate

  assign carry = carries[BUS_WIDTH-1];
endmodule
