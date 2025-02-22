
module half_adder(output sum, output carry, input a, input b);
  assign sum = a ^ b;
  assign carry = a & b;
endmodule

module full_adder(output sum, output carry, input a, input b, input c);
  assign sum = a ^ b ^ c;
  assign carry = (a & (b|c)) | (b&c);
endmodule

module add16(output carry, output [15:0] sum, input [15:0] a, input [15:0] b);
  wire [15:0] carries;

  genvar i;
  generate
    half_adder hadd(sum[0], carries[0], a[0], b[0]);
    for (i = 1; i < 16; i = i + 1) begin
      full_adder fadd(sum[i], carries[i], a[i], b[i], carries[i - 1]);
    end
  endgenerate

  assign carry = carries[15];
endmodule

