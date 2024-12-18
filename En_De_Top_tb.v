
`include "En_De_Top.v"

module En_De_Top_tb;

    // Parameters
    parameter DATA_SIZE = 16;
    parameter POLY_SIZE = 16;
    parameter SCALE_FACTOR = 2;

    // Testbench Signals
    reg clk;
    reg reset;
    reg [DATA_SIZE-1:0] data_in;
    wire [(DATA_SIZE+SCALE_FACTOR)*POLY_SIZE-1:0] encoded_data;
    wire [DATA_SIZE-1:0] data_out;

    // Instantiate the DUT (Device Under Test)
    En_De_Top #(
        .DATA_SIZE(DATA_SIZE),
        .POLY_SIZE(POLY_SIZE),
        .SCALE_FACTOR(SCALE_FACTOR)
    ) DUT (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .encoded_data(encoded_data),
        .data_out(data_out)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock (10 ns period)
    end

    // Test Procedure
    initial begin
        // Initialize Inputs
        reset = 1;
        data_in = 0;

        // Apply Reset
        #20 reset = 0; // Deassert reset after 20 ns

        // Test Case 1: Input data = 5
        #10 data_in = 5;
        #20; // Wait for processing

        // Check outputs
        $display("Input: %d, Encoded: %d, Decoded: %d", data_in, encoded_data, data_out);

        // Test Case 2: Input data = 25
        #10 data_in = 25;
        #20; // Wait for processing

        // Check outputs
        $display("Input: %d, Encoded: %d, Decoded: %d", data_in, encoded_data, data_out);

        // Test Case 3: Input data = 123
        #10 data_in = 123;
        #20; // Wait for processing

        // Check outputs
        $display("Input: %d, Encoded: %d, Decoded: %d", data_in, encoded_data, data_out);

        // Test Case 4: Edge case: Input data = 0
        #10 data_in = 0;
        #20; // Wait for processing

        // Check outputs
        $display("Input: %d, Encoded: %d, Decoded: %d", data_in, encoded_data, data_out);

        // Test Case 5: Edge case: Maximum Input
        #10 data_in = (2**DATA_SIZE)-1; // Max input for 16-bit data
        #20; // Wait for processing

        // Check outputs
        $display("Input: %d, Encoded: %d, Decoded: %d", data_in, encoded_data, data_out);

        // End simulation
        #50 $finish;
    end

    initial
begin
  $dumpfile("output.vcd");
  $dumpvars(1);
  
end

endmodule