`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 11:05:57 AM
// Design Name: 
// Module Name: m21
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


module m21_16(
    output [15:0] Y,
    input [15:0] D0, D1, 
    input S
    
    
);

wire [15:0] T1, T2;
//wire Sbar; Not needed anymore

/**
wire [15:0] Sel  = {16{S}}; //Replicate since structural Verilog requires gate operands to have same # of bits
wire [15:0] Selbar;
Not needed anymore
*/ 

assign Y = S ? D1 : D0;

endmodule
