`timescale 1ns / 1ps

module Seg7x16(
    input clk,
    input rst,
    input ena,
    input [31:0] i_number,
    output [7:0] o_seg,
    output [7:0] o_sel
    );

    reg [3:0] seg_data_r;
    reg [7:0] o_seg_r;
    reg [14:0] cnt;
    reg [7:0] o_sel_r;
    wire dt_clk = cnt[14]; 
    reg [2:0] dt_addr;
    reg [31:0] i_number_store;

    assign o_sel = o_sel_r;
    assign o_seg = o_seg_r;

    // CLK_divider(clk, rst, dt_clk);

    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
            cnt <= 0;
        else 
            cnt <= cnt + 1'b1;
    end

    always @(posedge dt_clk) 
    begin
        if (rst) 
            dt_addr <= 0;
        else
            dt_addr <= dt_addr + 1'b1;
    end

    always @(*)
    begin
        case (dt_addr)
            7 : o_sel_r = 8'b01111111;
            6 : o_sel_r = 8'b10111111;
            5 : o_sel_r = 8'b11011111;
            4 : o_sel_r = 8'b11101111;
            3 : o_sel_r = 8'b11110111;
            2 : o_sel_r = 8'b11111011;
            1 : o_sel_r = 8'b11111101;
            0 : o_sel_r = 8'b11111110;
        endcase
    end
    
    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
            i_number_store <= 0;
        else if (ena) 
            i_number_store <= i_number;
    end

    always @(*) 
    begin
        case (dt_addr)
              0 : seg_data_r = i_number_store[3:0];
              1 : seg_data_r = i_number_store[7:4];
              2 : seg_data_r = i_number_store[11:8];
              3 : seg_data_r = i_number_store[15:12];
              4 : seg_data_r = i_number_store[19:16];
              5 : seg_data_r = i_number_store[23:20];
              6 : seg_data_r = i_number_store[27:24];
              7 : seg_data_r = i_number_store[31:28];
        endcase    
    end

    always @(posedge clk or posedge rst) 
    begin
        if (rst) 
            o_seg_r <= 8'hff;
        else 
        begin
            case(seg_data_r)
                4'h0 : o_seg_r <= 8'b11000000;
                4'h1 : o_seg_r <= 8'b11111001;
                4'h2 : o_seg_r <= 8'b10100100;
                4'h3 : o_seg_r <= 8'b10110000;
                4'h4 : o_seg_r <= 8'b10011001;
                4'h5 : o_seg_r <= 8'b10010010;
                4'h6 : o_seg_r <= 8'b10000010;
                4'h7 : o_seg_r <= 8'b11111000;
                4'h8 : o_seg_r <= 8'b10000000;
                4'h9 : o_seg_r <= 8'b10010000;
                4'hA : o_seg_r <= 8'b10001000;
                4'hB : o_seg_r <= 8'b10000011;
                4'hC : o_seg_r <= 8'b11000110;
                4'hD : o_seg_r <= 8'b10100001;
                4'hE : o_seg_r <= 8'b10000110;
                4'hF : o_seg_r <= 8'b10001110;
            endcase
        end
    end
endmodule