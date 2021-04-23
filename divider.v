`timescale 1ns / 1ps

module divider(
    input clk_in,
    input rst,
    output clk_out1,
    output clk_out2
    );
    reg [31:0] clk = 32'b0;
    always @(posedge clk_in or posedge rst)
    begin
        if(rst)
        begin
            clk <= 16'b0;
        end
        else
        begin
            clk <= clk + 1'b1;
        end
    end
    assign clk_out1 = clk[15];
    assign clk_out2 = clk[20];
endmodule
