`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2022 01:23:08 PM
// Design Name: 
// Module Name: top
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


module top(start, mode, clk, reset, hours_i, mins_i, secs_i, A_P_i, VGA_HS_O, VGA_VS_O, VGA_R, VGA_G, VGA_B);
    input clk, reset, start;
    input[1:0]mode;
    input hours_i;
    input mins_i;
    input secs_i;
    input A_P_i;

    
    wire [6:0]hours1_o;
    wire [6:0]mins1_o;
    wire [6:0]secs1_o;
    wire [6:0]hours2_o;
    wire [6:0]mins2_o;
    wire [6:0]secs2_o;
    wire [6:0]A_P_o;
    
    output VGA_HS_O;       // horizontal sync output
    output VGA_VS_O;       // vertical sync output
    output [3:0] VGA_R;    // 4-bit VGA red output
    output [3:0] VGA_G;    // 4-bit VGA green output
    output [3:0] VGA_B;     // 4-bit VGA blue output
    
    //divided clk signal
    wire clk_1sec;
    
    //internal after DEBOUNCE
    wire deb_hours_o;
    wire deb_mins_o;
    wire deb_secs_o;
    
    //internal after COUNT
    wire [5:0]count_hours_o;
    wire [5:0]count_mins_o;
    wire [5:0]count_secs_o;
    
    //internal after SET
    wire [5:0]set_hours24;
    wire [5:0]set_mins24;
    wire [5:0]set_secs24;
    wire [5:0]set_hours12;
    wire [5:0]set_mins12;
    wire [5:0]set_secs12;
    wire set_AP12;
    
    //internal FROM MODULE
    wire [5:0]hours_12;
    wire [5:0]mins_12;
    wire [5:0]secs_12;
    wire A_P_12;
    
    wire [5:0]hours_24;
    wire [5:0]mins_24;
    wire [5:0]secs_24;
    
    wire [5:0]hours_stop;
    wire [5:0]mins_stop;
    wire [5:0]secs_stop;
    
    wire [5:0]hours_timer;
    wire [5:0]mins_timer;
    wire [5:0]secs_timer;
    
    //MUX outputs
    reg [5:0]mux_hours;
    reg [5:0]mux_mins;
    reg [5:0]mux_secs;
    
    //digits
    wire [5:0] hours1, hours2, mins1, mins2, secs1, secs2;
    
    wire [6:0]AP_out;
    
        
    //divide clock to 1Hz
    clock_divider_1sec div_1sec(.clk_i(clk), .reset(reset), .clk_o(clk_1sec));
    
    //debouncers
    debouncer deb_hours(.clk(clk), .reset(reset), .button_i(hours_i), .button_o(deb_hours_o));
    debouncer deb_mins(.clk(clk), .reset(reset), .button_i(mins_i), .button_o(deb_mins_o));
    debouncer deb_secs(.clk(clk), .reset(reset), .button_i(secs_i), .button_o(deb_secs_o));
    
    //counters
    counter6 count_hours(.reset(reset), .inc(deb_hours_o), .count(count_hours_o));
    counter6 count_mins(.reset(reset), .inc(deb_mins_o), .count(count_mins_o));
    counter6 count_secs(.reset(reset), .inc(deb_secs_o), .count(count_secs_o));
    
    //set times for all modules
    set_time24 set_time24(.hours_i(count_hours_o), .mins_i(count_mins_o), .secs_i(count_secs_o), .hours_o(set_hours24), .mins_o(set_mins24), .secs_o(set_secs24));
    set_time12 set_time12(.hours_i(count_hours_o), .mins_i(count_mins_o), .secs_i(count_secs_o), .A_P_i(A_P_i), .hours_o(set_hours12), .mins_o(set_mins12), .secs_o(set_secs12), .A_P_o(set_AP12));
    
    //instantiate all modules
    clock12 clock12(.start(start), .reset(reset), .clk(clk_1sec), .hours_i(set_hours12), .mins_i(set_mins12), .secs_i(set_secs12), .A_P_i(set_AP12), .hours_o(hours_12), .mins_o(mins_12), .secs_o(secs_12), .A_P_o(A_P_12));
    clock24 clock24(.start(start), .reset(reset), .clk(clk_1sec), .hours_i(set_hours24), .mins_i(set_mins24), .secs_i(set_secs24), .hours_o(hours_24), .mins_o(mins_24), .secs_o(secs_24));
    stopwatch stopwatch(.reset(reset), .start(start), .clk(clk_1sec), .hours_o(hours_stop), .mins_o(mins_stop), .secs_o(secs_stop));
    timer timer(.start(start), .reset(reset), .clk(clk_1sec), .hours_i(set_hours24), .mins_i(set_mins24), .secs_i(set_secs24), .hours_o(hours_timer), .mins_o(mins_timer), .secs_o(secs_timer));
    
    //hours MUX
    always@(mode) begin
        case(mode)
            2'b00: mux_hours <= hours_24;
            2'b01: mux_hours <= hours_12;
            2'b10: mux_hours <= hours_stop;
            2'b11: mux_hours <= hours_timer;
       endcase
   end
   
    //mins MUX
    always@(mode) begin
        case(mode)
            2'b00: mux_mins <= mins_24;
            2'b01: mux_mins <= mins_12;
            2'b10: mux_mins <= mins_stop;
            2'b11: mux_mins <= mins_timer;
       endcase
   end
   
    //secs MUX
    always@(mode) begin
        case(mode)
            2'b00: mux_secs <= secs_24;
            2'b01: mux_secs <= secs_12;
            2'b10: mux_secs <= secs_stop;
            2'b11: mux_secs <= secs_timer;
       endcase
   end
   
   
   //binary to BCD converters
   binary_bcd_converter conv_hours(.binary_i(mux_hours), .first_o(hours1), .second_o(hours2));
   binary_bcd_converter conv_mins(.binary_i(mux_mins), .first_o(mins1), .second_o(mins2));
   binary_bcd_converter conv_secs(.binary_i(mux_secs), .first_o(secs1), .second_o(secs2));
   
   
   //AM/PM display
   AP_output APout(.mode(mode), .AP_i(A_P_12), .reset(reset), .AP_o(AP_out));
   
   seven_segment_decoder seg_hours1(.in(hours1), .reset(reset), .out(hours1_o));
   seven_segment_decoder seg_hours2(.in(hours2), .reset(reset), .out(hours2_o));
   seven_segment_decoder seg_mins1(.in(mins1), .reset(reset), .out(mins1_o));
   seven_segment_decoder seg_mins2(.in(mins2), .reset(reset), .out(mins2_o));
   seven_segment_decoder seg_secs1(.in(secs1), .reset(reset), .out(secs1_o));
   seven_segment_decoder seg_secs2(.in(secs2), .reset(reset), .out(secs2_o));
   AP_7segment AP(.AP_i(AP_out), .reset(reset), .AP_o(A_P_o));

   top_square square(.CLK(clk), .RST_BTN(reset), .h1(hours1_o), .h2(hours2_o), .m1(mins1_o), .m2(mins2_o), .s1(secs1_o), .s2(secs2_o), .ap(A_P_o), .VGA_HS_O(VGA_HS_O), .VGA_VS_O(VGA_VS_O), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));

    
endmodule
