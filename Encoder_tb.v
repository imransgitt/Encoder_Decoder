
/**`include "Encoder.v"

module Encoder_tb;

    // Parameters
    parameter POLY_SIZE = 16;
    parameter INPUT_WIDTH = 16;
    parameter SCALE_FACTOR = 10;

    // Testbench signals
    reg clk;
    reg reset;
    reg [INPUT_WIDTH-1:0] binary_data;
    reg [3:0] index;
    wire [(INPUT_WIDTH+SCALE_FACTOR)*POLY_SIZE-1:0] poly_coeff;

    // Instantiate the CKKS_Encoder module
    Encoder #(
        .POLY_SIZE(POLY_SIZE),
        .INPUT_WIDTH(INPUT_WIDTH),
        .SCALE_FACTOR(SCALE_FACTOR)
    ) dut (
        .clk(clk),
        .reset(reset),
        .binary_data(binary_data),
        .index(index),
        .poly_coeff(poly_coeff)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset <= 1;
        binary_data <= 0;
        index <= 0;

        // Apply reset
        #10 reset <= 0;

        // Test case 1: Load binary_data at index 0
        binary_data <= 4'b1010; // Example input
        index <= 4; // Write to index 4

        #10
        binary_data <= 4'b0110; // Example input
        index <= 4; // Write to index 4


        // Add more test cases as needed
        #20;
        $finish; // End simulation
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %t | Reset: %b | Binary Data: %b | Index: %d | Poly Coeff: %d",
                 $time, reset, binary_data, index, poly_coeff);
    end

endmodule
**/
