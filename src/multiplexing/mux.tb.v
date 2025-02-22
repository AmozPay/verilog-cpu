`include "src/multiplexing/mux.v"

module tb_mux2;
    parameter BUS_WIDTH = 1;
    wire [BUS_WIDTH-1:0] mux_out;
    reg [BUS_WIDTH-1:0] mux_in0;
    reg [BUS_WIDTH-1:0] mux_in1;
    reg sel0;

    mux2 #(.BUS_WIDTH(BUS_WIDTH)) mux2_0(mux_out, mux_in0, mux_in1, sel0);

    initial begin
        $dumpfile("mux2.vcd");
        $dumpvars(0, tb_mux2);
        mux_in0 = 0;
        mux_in1 = 1;
        sel0 = 0;
        #10;
        sel0 = 1;
        #10;
    end
endmodule

module tb_mux4;
    parameter BUS_WIDTH = 2;
    wire [BUS_WIDTH-1:0] mux_out;
    reg [BUS_WIDTH-1:0] mux_in0, mux_in1, mux_in2, mux_in3;
    reg [1:0] sel;

    mux4 #(.BUS_WIDTH(BUS_WIDTH)) mux4(mux_out, mux_in0, mux_in1, mux_in2, mux_in3, {sel[0], sel[1]});

    initial begin
        $dumpfile("mux4.vcd");
        $dumpvars(0, tb_mux4);
        mux_in0 = 0;
        mux_in1 = 1;
        mux_in2 = 2;
        mux_in3 = 3;
        sel = 0;
        #10;
        sel = 1;
        #10;
        sel = 2;
        #10;
        sel = 3;
        #10;
    end
endmodule

module tb_mux8;
    parameter BUS_WIDTH = 3;
    wire [BUS_WIDTH-1:0] mux_out;
    reg [BUS_WIDTH-1:0] mux_in [7:0];
    reg [2:0] sel;

    mux8 #(.BUS_WIDTH(BUS_WIDTH)) mux8(
        mux_out,
        mux_in[0], mux_in[1], mux_in[2], mux_in[3],
        mux_in[4], mux_in[5], mux_in[6], mux_in[7],
        {sel[0], sel[1], sel[2]}
    );

    integer i;
    initial begin
        $dumpfile("mux8.vcd");
        $dumpvars(0, tb_mux8);
        for (i = 0; i < 8; i = i + 1) begin
            mux_in[i] = i;
        end
        for (i = 0; i < 8; i = i + 1) begin
            sel = i;
            #10;
        end
    end
endmodule


module tb_mux16;
    parameter BUS_WIDTH = 4;
    wire [BUS_WIDTH-1:0] mux_out;
    reg [BUS_WIDTH-1:0] mux_in [15:0];
    reg [3:0] sel;

    mux16 #(.BUS_WIDTH(BUS_WIDTH)) mux8(
        mux_out,
        mux_in[0], mux_in[1], mux_in[2], mux_in[3],
        mux_in[4], mux_in[5], mux_in[6], mux_in[7],
        mux_in[8], mux_in[9], mux_in[10], mux_in[11],
        mux_in[12], mux_in[13], mux_in[14], mux_in[15],
        {sel[0], sel[1], sel[2], sel[3]}
    );

    integer i, j;
    initial begin
        $dumpfile("mux16.vcd");
        $dumpvars(0, tb_mux16);
        for (i = 0; i < 16; i = i + 1) begin
            mux_in[i] = i;
        end
        for (i = 0; i < 16; i = i + 1) begin
            sel = i;
            #10;
        end
    end
endmodule
