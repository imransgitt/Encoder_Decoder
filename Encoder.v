
module Encoder #(
    parameter POLY_SIZE = 16,
    parameter INPUT_WIDTH = 16,
    parameter SCALE_FACTOR = 2
    )(
        input clk,
        input reset,
        input [INPUT_WIDTH-1:0] binary_data,
        output reg [(INPUT_WIDTH+SCALE_FACTOR)*POLY_SIZE-1:0] poly_coeff
        );  

integer i;
reg [INPUT_WIDTH + SCALE_FACTOR-1:0] poly_internal[0:POLY_SIZE-1]; // Internal unpacked array

//1st always block
always@(posedge clk or posedge reset)
begin
  if(reset)
    begin
    for(i=0;i<POLY_SIZE;i++)
        begin
            poly_internal[i] <= 0; //reset the polynomial coeffiecients
        end
    end

  else 
    begin
    for(i=0;i<POLY_SIZE;i++)
        begin
            poly_internal[i] <= binary_data << SCALE_FACTOR; //scale the input data by the scaling factor ie(i/p*2^10)
        end 
    end
end

//2nd always block
always @(*) begin
    for (i = 0; i < POLY_SIZE; i = i + 1) begin
        poly_coeff[(i+1)*(INPUT_WIDTH+SCALE_FACTOR)-1 -: (INPUT_WIDTH+SCALE_FACTOR)] = poly_internal[i];
    end
end

 endmodule

