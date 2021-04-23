`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/22 19:46:17
// Design Name: 
// Module Name: Top
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


module Top(
    input clk,
    input rst,
    output [7:0] Seg,
    output [7:0] Sel
    );

    wire [31:0] data_check;
    wire [31:0] pc_check;
    wire clk_cpu;
    wire clk_seg;
        
    Seg7x16 segdt(
        clk,
        rst,
        1'b1,
        data_check,
        Seg,
        Sel
    );

    openmips_min_sopc sopc(
        clk_cpu,
        rst,
        data_check,
        pc_check
    );
    
    divider divi(
        clk,
        rst,
        clk_seg,
        clk_cpu
    );
    
    
endmodule
