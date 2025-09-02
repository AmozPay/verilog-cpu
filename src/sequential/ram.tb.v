`include "src/sequential/ram.v"

// module tb_ram8;
//   parameter BIT_WIDTH = 3;

//   reg [BIT_WIDTH-1:0] in, address;
//   wire [BIT_WIDTH-1:0] out [7:0];
//   reg load, clock, reset;


//   ram8 #(.BIT_WIDTH(BIT_WIDTH)) ram(out, in, address, load, clock, reset);
//   initial begin
//     forever #5 clock = ~clock;
//   end


//   integer i;
//   initial begin
//     $dumpfile("ram.vcd");
//     $dumpvars(0, tb_ram8);

//     load = 0; clock = 0; reset = 0; #10;
//     reset = 1; #10;
//     reset = 0; #10;

//     load = 1;
//     for (i = 0; i < 8; i = i + 1) begin
//       address = i;
//       in = i;
//       #10;
//       $display("out[%d]=%d", i, out[i]);
//     end

//     address = 0; in = 5; #10;
//     $display("out[0]=%d", out[5]);


//     $finish;
//   end
// endmodule

module tb_p_ram;
  parameter NB_SEL = 4;
  parameter BIT_WIDTH = 4;

  reg [BIT_WIDTH-1:0] in, address;
  wire [BIT_WIDTH-1:0] out [2 ** NB_SEL-1:0];
  reg load, clock, reset;


  p_ram #(.BIT_WIDTH(BIT_WIDTH), .SEL_WIDTH(NB_SEL)) ram(out, in, address, load, clock, reset);
  initial begin
    forever #5 clock = ~clock;
  end


  integer i;
  initial begin
    $dumpfile("ram.vcd");
    $dumpvars(0, tb_p_ram);

    load = 0; clock = 0; reset = 0; #10;
    reset = 1; #10;
    reset = 0; #10;

    load = 1;
    for (i = 0; i < 2 ** NB_SEL; i = i + 1) begin
      address = i;
      in = i;
      #10;
      $display("out[%d]=%d", i, out[i]);
    end

    address = 0; in = 5; #10;
    $display("out[0]=%d", out[5]);


    $finish;
  end
endmodule