`timescale 1ns / 1ps


module seven_segment_decoder(in, reset, out);
    input [5:0]in;
    input reset;
    output reg [6:0]out;
    
    always @(*) begin
        if (!reset)
            out <= 7'b1111111;
        else
            case (in)
                4'b0000: out <= 7'b0000001;
                4'b0001: out <= 7'b1001111;
                4'b0010: out <= 7'b0010010;
                4'b0011: out <= 7'b0000110;
                4'b0100: out <= 7'b1001100;
                4'b0101: out <= 7'b0100100;
                4'b0110: out <= 7'b0100000;
                4'b0111: out <= 7'b0001111;
                4'b1000: out <= 7'b0000000;
                4'b1001: out <= 7'b0000100;
                
                default: out <= 7'b1111111;
            endcase
        end
    
endmodule