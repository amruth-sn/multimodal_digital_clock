`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 06:44:04 PM
// Design Name: 
// Module Name: binary_bcd_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module binary_bcd_converter(binary_i, first_o, second_o);
    input [5:0]binary_i;
    output reg [3:0]first_o;
    output reg [3:0]second_o;
    
    
    always@(binary_i) begin
        second_o <= binary_i % 4'd10;
        first_o <= (binary_i - (binary_i % 4'd10))/4'd10;
    end
    

endmodule
