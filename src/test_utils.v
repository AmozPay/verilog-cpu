
interface test_intf #(parameter WIDTH = 8);
    logic [WIDTH-1:0] inputs;
    wire out;

    modport tb (
        input inputs,
        output out
    );
endinterface

module test_module #(parameter WIDTH=2) (input test_intf intf);
    task run_test;
        integer i, j;
        begin
            for (i = 0; i < 2 ** intf.WIDTH; i = i + 1) begin
                for (j = 0; j < intf.WIDTH; j = j + 1) begin
                    intf.inputs[j] = (i >> j) & 1;
                end
                #10;  // Wait for the device to process the inputs.
                $display("Test vector %d applied, output: %b", i, intf.output);
            end
        end
    endtask
endmodule
