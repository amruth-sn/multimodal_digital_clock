`timescale 1ns / 1ps


module clock_divider1k(clk_i, reset, clk_o);
    input clk_i, reset;
    output reg clk_o;
    
    parameter DIV = 28'd100000;
    reg[27:0]count = 28'd0;


    always @ (posedge clk_i or negedge reset) begin
        if (!reset)
            clk_o <= 0;
        else begin
            count <= count + 28'd1;
            if (count >= (DIV-1))
                count <= 28'd0;
            clk_o <= (count<DIV/2)?1'b1:1'b0;
        end
    end //always    

endmodule