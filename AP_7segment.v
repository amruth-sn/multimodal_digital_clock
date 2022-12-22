`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 12:39:31 PM
// Design Name: 
// Module Name: AP_7segment
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


module AP_7segment(AP_i, reset, AP_o);
    input [6:0]AP_i;
    input reset;
    output reg [6:0]AP_o;

    always @(*) begin
        if (!reset)
            AP_o <= 7'b1111111; // BLANK
        else begin
            case (AP_i)
                7'b0000000: AP_o <= 7'b0001000; // "A"
                7'b0000001: AP_o <= 7'b0011000; // "P"
                default: AP_o <= 7'b1111111; // BLANK
            endcase
            end
        end
endmodule
