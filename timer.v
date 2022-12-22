`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2022 12:42:16 PM
// Design Name: 
// Module Name: timer
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

//FIX LOGIC ERRORS


module timer(start, reset, clk, hours_i, mins_i, secs_i, hours_o, mins_o, secs_o);

input reset, start, clk;
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
        
        
    end else if(start) begin
        hours_int <= hours_i;
        mins_int <= mins_i;
        secs_int <= secs_i;
    end else if (hours_int == 0 && mins_int == 0 && secs_int == 0) begin
        hours_int <= 0;
        mins_int <= 0;
        secs_int <= 0;
        
    end else begin   
        if(secs_int == 0) begin
            secs_int <= 59;
            if(mins_int == 0) begin
                mins_int <= 59;
                hours_int <= hours_int - 1;
            end else begin
            mins_int <= mins_int - 1; 
            end
         end else begin
    secs_int <= secs_int - 1; end
    end
 end // always
 

assign hours_o = hours_int;
assign mins_o = mins_int;
assign secs_o = secs_int;

endmodule
