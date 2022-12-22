`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 03:59:17 PM
// Design Name: 
// Module Name: set_time12
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


module set_time12(hours_i, mins_i, secs_i, A_P_i, hours_o, mins_o, secs_o, A_P_o);
    input [4:0]hours_i;
    input [5:0]mins_i;
    input [5:0]secs_i;
    input A_P_i;
    output [4:0]hours_o;
    output [5:0]mins_o;
    output [5:0]secs_o;
    output A_P_o;
    
    
    assign hours_o = hours_i;
    assign mins_o = mins_i;
    assign secs_o = secs_i;
    assign A_P_o = A_P_i;
   

endmodule