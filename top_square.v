`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2020 12:29:25 PM
// Design Name: 
// Module Name: top_square
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
//////////////////////////////////////////////////////////////////////////////
module top_square(
    input wire CLK,             // board clock: 100 MHz on Nexys
    input wire RST_BTN,
    input wire [6:0] h1,
    input wire [6:0] h2,
    input wire [6:0] m1,
    input wire [6:0] m2,
    input wire [6:0] s1,
    input wire [6:0] s2,
    input wire [6:0] ap,
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green output
    output wire [3:0] VGA_B     // 4-bit VGA blue output
    );

    wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video
    

    // generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
    always @(posedge CLK)
        {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511

    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y)
    );

    // Wires to hold regions on FPGA
    wire SQ1;
    //,SQ2,SQ3,SQ4,SQ5,SQ6,SQ7,SQ8,SQ9,SQ10,SQ11,SQ12,SQ13,SQ14,SQ15,SQ16,SQ17,SQMid,SQ10hit,SQ11hit,SQ12hit,SQ13hit,SQ14hit,SQ15hit,SQ16hit,SQ17hit;
	
//    //Registers for entities
	reg green,grid;
	
//	// Creating Regions on the VGA Display represented as wires (640x480)
	
//	// SQ1 is a large Square, and SQ2-9, along with SQ Mid are areas within SQ1
    assign SQ1 = ((x > -1) & (y > -1) & (x < 641) & (y < 481)) ? 1 : 0;

    wire H1_0, H1_1, H1_2, H1_3, H1_4, H1_5, H1_6, H2_0, H2_1, H2_2, H2_3, H2_4, H2_5, H2_6, 
        M1_0, M1_1, M1_2, M1_3, M1_4, M1_5, M1_6, M2_0, M2_1, M2_2, M2_3, M2_4, M2_5, M2_6, 
        S1_0, S1_1, S1_2, S1_3, S1_4, S1_5, S1_6, S2_0, S2_1, S2_2, S2_3, S2_4, S2_5, S2_6; 
    wire colonHM_1, colonHM_2, colonMS_1, colonMS_2; //add ms functionality if necessary
//    wire A_P0, A_P1, A_P2, A_P3, A_P4, A_P5, A_P6;                                                     //0-3, 1-2, 4-5
    //HOUR 1 DIGIT
    assign H1_0 = ((x > 75) & (y > 185) & (x < 105) & (y < 200)) ? 1 : 0;
    assign H1_1 = ((x > 105) & (y > 200) & (x < 120) & (y < 230)) ? 1 : 0;
    assign H1_2 = ((x > 105) & (y > 230) & (x < 120) & (y < 260)) ? 1 : 0; 
    assign H1_3 = ((x > 75) & (y > 260) & (x < 105) & (y < 275)) ? 1 : 0; 
    assign H1_4 = ((x > 60) & (y > 230) & (x < 75) & (y < 260)) ? 1 : 0; 
    assign H1_5 = ((x > 60) & (y > 200) & (x < 75) & (y < 230)) ? 1 : 0;
    assign H1_6 = ((x > 75) & (y > 222) & (x < 105) & (y < 238)) ? 1 : 0; //don't change y-value for #6, or for any of them really. numbers are stacked horizontally, not vertically
    //HOUR 2 DIGIT                                                                     
    assign H2_0 = ((x > 150) & (y > 185) & (x < 180) & (y < 200)) ? 1 : 0;
    assign H2_1 = ((x > 180) & (y > 200) & (x < 195) & (y < 230)) ? 1 : 0;
    assign H2_2 = ((x > 180) & (y > 230) & (x < 195) & (y < 260)) ? 1 : 0;
    assign H2_3 = ((x > 150) & (y > 260) & (x < 180) & (y < 275)) ? 1 : 0; //added 75 to H1 x-locations
    assign H2_4 = ((x > 135) & (y > 230) & (x < 150) & (y < 260)) ? 1 : 0;
    assign H2_5 = ((x > 135) & (y > 200) & (x < 150) & (y < 230)) ? 1 : 0;
    assign H2_6 = ((x > 150) & (y > 222) & (x < 180) & (y < 238)) ? 1 : 0;
    //COLON HM DOTS
    assign colonHM_1 = ((x > 225) & (y > 200) & (x < 240) & (y < 215)) ? 1 : 0;
    assign colonHM_2 = ((x > 225) & (y > 245) & (x < 240) & (y < 260)) ? 1 : 0;

    //MINUTE 1 DIGIT
    assign M1_0 = ((x > 285) & (y > 185) & (x < 315) & (y < 200)) ? 1 : 0;
    assign M1_1 = ((x > 315) & (y > 200) & (x < 330) & (y < 230)) ? 1 : 0; //added 210 to H1 x-loc
    assign M1_2 = ((x > 315) & (y > 230) & (x < 330) & (y < 260)) ? 1 : 0;
    assign M1_3 = ((x > 285) & (y > 260) & (x < 315) & (y < 275)) ? 1 : 0;
    assign M1_4 = ((x > 270) & (y > 230) & (x < 285) & (y < 260)) ? 1 : 0;
    assign M1_5 = ((x > 270) & (y > 200) & (x < 285) & (y < 230)) ? 1 : 0;
    assign M1_6 = ((x > 285) & (y > 222) & (x < 315) & (y < 238)) ? 1 : 0;  
    //MINUTE 2 DIGIT                                                                     
    assign M2_0 = ((x > 360) & (y > 185) & (x < 390) & (y < 200)) ? 1 : 0;
    assign M2_1 = ((x > 390) & (y > 200) & (x < 405) & (y < 230)) ? 1 : 0;//added 75 to M1 x-loc
    assign M2_2 = ((x > 390) & (y > 230) & (x < 405) & (y < 260)) ? 1 : 0;
    assign M2_3 = ((x > 360) & (y > 260) & (x < 390) & (y < 275)) ? 1 : 0;
    assign M2_4 = ((x > 345) & (y > 230) & (x < 360) & (y < 260)) ? 1 : 0;
    assign M2_5 = ((x > 345) & (y > 200) & (x < 360) & (y < 230)) ? 1 : 0;
    assign M2_6 = ((x > 360) & (y > 222) & (x < 390) & (y < 238)) ? 1 : 0;
    //COLON MS DOTS
    assign colonMS_1 = ((x > 435) & (y > 200) & (x < 450) & (y < 215)) ? 1 : 0; //added 210 to CHM x-loc
    assign colonMS_2 = ((x > 435) & (y > 245) & (x < 450) & (y < 260)) ? 1 : 0;
    
    //SECOND 1 DIGIT
    assign S1_0 = ((x > 495) & (y > 185) & (x < 525) & (y < 200)) ? 1 : 0;
    assign S1_1 = ((x > 525) & (y > 200) & (x < 540) & (y < 230)) ? 1 : 0;
    assign S1_2 = ((x > 525) & (y > 230) & (x < 540) & (y < 260)) ? 1 : 0;
    assign S1_3 = ((x > 495) & (y > 260) & (x < 525) & (y < 275)) ? 1 : 0; //added 420 to H1 x-loc
    assign S1_4 = ((x > 480) & (y > 230) & (x < 495) & (y < 260)) ? 1 : 0;
    assign S1_5 = ((x > 480) & (y > 200) & (x < 495) & (y < 230)) ? 1 : 0;
    assign S1_6 = ((x > 495) & (y > 222) & (x < 525) & (y < 238)) ? 1 : 0; 
    //SECOND 2 DIGIT                                                                     
    assign S2_0 = ((x > 570) & (y > 185) & (x < 600) & (y < 200)) ? 1 : 0;
    assign S2_1 = ((x > 600) & (y > 200) & (x < 615) & (y < 230)) ? 1 : 0;
    assign S2_2 = ((x > 600) & (y > 230) & (x < 615) & (y < 260)) ? 1 : 0;
    assign S2_3 = ((x > 570) & (y > 260) & (x < 600) & (y < 275)) ? 1 : 0; //added 75 to S1 x-locations
    assign S2_4 = ((x > 555) & (y > 230) & (x < 570) & (y < 260)) ? 1 : 0;
    assign S2_5 = ((x > 555) & (y > 200) & (x < 570) & (y < 230)) ? 1 : 0;
    assign S2_6 = ((x > 570) & (y > 222) & (x < 600) & (y < 238)) ? 1 : 0;


 // Assign the registers to the VGA 3rd output. This will display strong red on the Screen when 
 // grid = 1, and strong green on the screen when green = 1;
 assign VGA_B[3] = 0;
 assign VGA_R[3] = grid;                    
 assign VGA_G = {0, grid, 0, 0}; 
  always @ (*)
  begin 
	//At start of every input change reset the screen and grid. Check inputs and update grid accordingly
	
	//Green = 0 means that there will be no values of x/y on the VGA that will display green
    green = 0;
	//This statement makes it so that within SQ1, the colons appear
    grid = SQ1 +colonHM_1+colonHM_2+colonMS_1+colonMS_2;
    if(h1[6] == 0) begin
        grid = grid + H1_0;   //h1 = 1001111 --> h1[0]
    end
    if(h1[5] == 0) begin
        grid = grid + H1_1;
    end
    if(h1[4] == 0) begin
        grid = grid + H1_2;
    end
    if(h1[3] == 0) begin
        grid = grid + H1_3;
    end
    if(h1[2] == 0) begin
        grid = grid + H1_4;
    end
    if(h1[1] == 0) begin
        grid = grid + H1_5;
    end
    if(h1[0] == 0) begin
        grid = grid + H1_6;
    end
    if(h2[6] == 0) begin
        grid = grid + H2_0;
    end
    if(h2[5] == 0) begin
        grid = grid + H2_1;
    end
    if(h2[4] == 0) begin
        grid = grid + H2_2;
    end
    if(h2[3] == 0) begin
        grid = grid + H2_3;
    end
    if(h2[2] == 0) begin
        grid = grid + H2_4;
    end
    if(h2[1] == 0) begin
        grid = grid + H2_5;
    end
    if(h2[0] == 0) begin
        grid = grid + H2_6;
    end
    if(m1[6] == 0) begin
        grid = grid + M1_0;
    end
    if(m1[5] == 0) begin
        grid = grid + M1_1;
    end
    if(m1[4] == 0) begin
        grid = grid + M1_2;
    end
    if(m1[3] == 0) begin
        grid = grid + M1_3;
    end
    if(m1[2] == 0) begin
        grid = grid + M1_4;
    end
    if(m1[1] == 0) begin
        grid = grid + M1_5;
    end
    if(m1[0] == 0) begin
        grid = grid + M1_6;
    end
    if(m2[6] == 0) begin
        grid = grid + M2_0;
    end
    if(m2[5] == 0) begin
        grid = grid + M2_1;
    end
    if(m2[4] == 0) begin
        grid = grid + M2_2;
    end
    if(m2[3] == 0) begin
        grid = grid + M2_3;
    end
    if(m2[2] == 0) begin
        grid = grid + M2_4;
    end
    if(m2[1] == 0) begin
        grid = grid + M2_5;
    end
    if(m2[0] == 0) begin
        grid = grid + M2_6;
    end
    if(s1[6] == 0) begin
        grid = grid + S1_0;
    end
    if(s1[5] == 0) begin
        grid = grid + S1_1;
    end
    if(s1[4] == 0) begin
        grid = grid + S1_2;
    end
    if(s1[3] == 0) begin
        grid = grid + S1_3;
    end
    if(s1[2] == 0) begin
        grid = grid + S1_4;
    end
    if(s1[1] == 0) begin
        grid = grid + S1_5;
    end
    if(s1[0] == 0) begin
        grid = grid + S1_6;
    end
    if(s2[6] == 0) begin
        grid = grid + S2_0;
    end
    if(s2[5] == 0) begin
        grid = grid + S2_1;
    end
    if(s2[4] == 0) begin
        grid = grid + S2_2;
    end
    if(s2[3] == 0) begin
        grid = grid + S2_3;
    end
    if(s2[2] == 0) begin
        grid = grid + S2_4;
    end
    if(s2[1] == 0) begin
        grid = grid + S2_5;
    end
    if(s2[0] == 0) begin
        grid = grid + S2_6;
    end
    end
    
    
endmodule
