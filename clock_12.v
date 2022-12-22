`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2022 12:40:27 PM
// Design Name: 
// Module Name: cloc_12
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

//"start" signal acts as reset

module clock12(start, reset, clk, hours_i, mins_i, secs_i, A_P_i, hours_o, mins_o, secs_o, A_P_o);

input start, reset, clk;
input [4:0] hours_i;
input [5:0] mins_i;
input [5:0] secs_i;
input A_P_i;

output [4:0] hours_o;
output [5:0] mins_o;
output [5:0] secs_o;
output A_P_o; // 0 is AM, 1 is PM


//internal registers
reg [4:0]hours_int;
reg [5:0]mins_int;
reg [5:0]secs_int;
reg A_P_int;

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        hours_int <= 1;
        mins_int <= 0;
        secs_int <= 0;
        A_P_int <= 0;
    end else if (start) begin
        hours_int <= hours_i + 1;
        mins_int <= mins_i;
        secs_int <= secs_i;
        A_P_int <= secs_i;
    end else begin
        secs_int <= secs_int + 1;
        if (secs_int == 59) begin
            secs_int <= 0;
            mins_int <= mins_int + 1;
            if (mins_int == 59) begin
                mins_int <= 0;
                hours_int <= hours_int + 1;
                if (hours_int == 12) begin 
                    hours_int <= 1;
                end
            end
        end
    end
 end // always

//asign outputs to internal registers
assign hours_o = hours_int;
assign mins_o = mins_int;
assign secs_o = secs_int;
assign A_P_o = A_P_int;

endmodule