`timescale 1ns / 1ps


module debouncer(clk, reset, button_i, button_o);

    input clk, reset, button_i;
    output reg button_o;
    
    integer deb_count = 0;
    reg deb_count_start;
    reg output_exist;
    
    parameter MAX = 1000000;
    
    always@(posedge clk or negedge reset) begin
        if (!reset) begin
            button_o <= 0;
            deb_count <= 0;
            deb_count_start <= 0;
            output_exist <= 0;
        end else begin
        case(button_i)
            0: {button_o, deb_count, deb_count_start, output_exist} = 0;
            1: if (output_exist==0) begin
                   if (deb_count_start==0) begin
                        deb_count_start <= 1;
                        deb_count <= deb_count + 1;
                            if (deb_count==MAX) begin
                                button_o <= 1;
                                deb_count_start <= 0;
                                deb_count <= 0;
                                output_exist <= 1; end end
                    else begin
                        deb_count <= deb_count + 1;
                        if (deb_count==MAX) begin
                            button_o <= 1;
                            deb_count_start <= 0;
                            deb_count <= 0;
                            output_exist <= 1; end
                    end //else
              end else
              button_o <= 0;
         endcase
         end //else
    end //always
    
endmodule