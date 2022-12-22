`timescale 1ns / 1ps


module counter6(reset, inc, count);

    input reset, inc;
    output reg [5:0]count; // bit-width=6
    
    always @ (posedge inc or negedge reset) begin
        if (!reset)
            count <= 0;
         else if (inc)
            count <= count + 1;
    end //always

endmodule