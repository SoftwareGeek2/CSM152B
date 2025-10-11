`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2025 10:37:18 AM
// Design Name: 
// Module Name: adder_16bit
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


module adder_16bit(
    input [15:0] r1,
    input [15:0] r2,
    input ci, // carry in
    output [15:0] result,
    output carry // carry out
    
    );
    
    wire c1, c2, c3; //carry-out intermediates

    adder_explicit u0 (.r1(r1[3:0]), .r2(r2[3:0]), .ci(ci), .result(result[3:0]), .carry(c1));
    adder_explicit u1 (.r1(r1[7:4]), .r2(r2[7:4]), .ci(c1), .result(result[7:4]), .carry(c2));
    adder_explicit u2 (.r1(r1[11:8]), .r2(r2[11:8]), .ci(c2), .result(result[11:8]), .carry(c3));
    adder_explicit u3 (.r1(r1[15:12]), .r2(r2[15:12]), .ci(c3), .result(result[15:12]), .carry(carry));
endmodule
