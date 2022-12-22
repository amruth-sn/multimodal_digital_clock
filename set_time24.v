`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 03:50:25 PM
// Design Name: 
// Module Name: set_time24
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

//setter used for clock24, stopwatch, timer


module set_time24(hours_i, mins_i, secs_i, hours_o, mins_o, secs_o);
    input [4:0]hours_i;
    input [5:0]mins_i;
    input [5:0]secs_i;
    output [4:0]hours_o;
    output [5:0]mins_o;
    output [5:0]secs_o;
    
    assign hours_o = hours_i;
    assign mins_o = mins_i;
    assign secs_o = secs_i;
   
endmodule
