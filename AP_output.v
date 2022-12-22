`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 12:47:26 PM
// Design Name: 
// Module Name: AP_output
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


module AP_output(mode, AP_i, reset, AP_o);

    input [1:0]mode;
    input reset, AP_i;
    output reg [6:0]AP_o;
    
    always@(mode) begin
        if (mode == 2'b01)
            AP_o <= AP_i;
        else
            AP_o <= 7'b1111111;
    end
endmodule
