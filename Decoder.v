

module Decoder #(
    parameter POLY_SIZE = 16,       // Number of coefficients
    parameter OUTPUT_WIDTH = 16,   // Bit width of the output binary data
    parameter SCALE_FACTOR = 2    // Scaling factor used during encoding
)(
    input [(OUTPUT_WIDTH+SCALE_FACTOR)*POLY_SIZE-1:0] poly_coeff, // Flattened array
    output reg [OUTPUT_WIDTH-1:0] binary_data // Decoded binary data
);

reg [OUTPUT_WIDTH+SCALE_FACTOR-1:0] selected_coeff; // To hold the selected coefficient

always @(*) begin
    // Extract the selected coefficient from the flattened array
    selected_coeff = poly_coeff[(OUTPUT_WIDTH+SCALE_FACTOR)-1 -: (OUTPUT_WIDTH+SCALE_FACTOR)];
    // Perform reverse scaling
    binary_data <= selected_coeff >> SCALE_FACTOR;
end

endmodule
