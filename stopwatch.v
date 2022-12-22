`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2022 12:41:58 PM
// Design Name: 
// Module Name: stopwatch
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



module stopwatch(start, reset, clk, hours_o, mins_o, secs_o);

input start, reset, clk;

output reg [4:0] hours_o;
output reg [5:0] mins_o;
output reg [5:0] secs_o;

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        hours_o <= 0;
        mins_o <= 0;
        secs_o <= 0;
    end else if (start) begin    
        secs_o <= secs_o + 1;
        if (secs_o == 60) begin
            secs_o <= 0;
            mins_o <= mins_o + 1;
            if (mins_o == 60) begin
                mins_o <= 0;
                hours_o <= hours_o + 1;
            end
        end
    end 
 end // always


endmodule
