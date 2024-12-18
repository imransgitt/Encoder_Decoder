`include "Encoder.v"
`include "Decoder.v"


module En_De_Top #( 
    parameter DATA_SIZE = 16,
    parameter POLY_SIZE = 16,
    parameter SCALE_FACTOR = 2

)(   
    input clk,
    input reset,
    input [DATA_SIZE-1:0] data_in,
    output[(DATA_SIZE+SCALE_FACTOR)*POLY_SIZE-1:0] encoded_data,
    output [DATA_SIZE-1:0] data_out
);


wire [(DATA_SIZE+SCALE_FACTOR)*POLY_SIZE-1:0] w_encoded_data;

//module instantiation 

Encoder E1 (.clk(clk),.reset(reset),.binary_data(data_in),.poly_coeff(w_encoded_data));
Decoder D1 (.poly_coeff(w_encoded_data),.binary_data(data_out));

assign encoded_data = w_encoded_data;

endmodule