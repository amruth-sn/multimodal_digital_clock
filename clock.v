`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2021 06:41:32 PM
// Design Name: 
// Module Name: clock24
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


module clock24(start, reset, clk, hours_i, mins_i, secs_i, hours_o, mins_o, secs_o);

input reset, clk, start;
input [4:0]hours_i;
input [5:0]mins_i;
input[5:0]secs_i;

output [4:0] hours_o;
output [5:0] mins_o;
output [5:0] secs_o;

//internal registers
reg [4:0]hours_int;
reg [5:0]mins_int;
reg [5:0]secs_int;

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        hours_int <= 0;
        mins_int <= 0;
        secs_int <= 0;
    end else if (start) begin
        hours_int <= hours_i;
        mins_int <= mins_i;
        secs_int <= secs_i;
    end else begin
        secs_int <= secs_int + 1;
        if (secs_int == 59) begin
            secs_int <= 0;
            mins_int <= mins_int + 1;
            if (mins_int == 59) begin
                mins_int <= 0;
                hours_int <= hours_int + 1;
                if (hours_int == 23) begin
                    hours_int <= 0;
                end
            end
        end
    end
 end // always
 
//asign outputs to internal registers
assign hours_o = hours_int;
assign mins_o = mins_int;
assign secs_o = secs_int;

endmodule