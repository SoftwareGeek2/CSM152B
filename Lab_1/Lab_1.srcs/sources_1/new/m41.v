`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 11:12:08 AM
// Design Name: 
// Module Name: m41
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
/**
counter uut(
        .clock(clock),
        .reset(reset),
        .enable(enable),
        .counter_out(counter_out)
    );
    */
// 
//////////////////////////////////////////////////////////////////////////////////


module m41(
    input clock,
    output Y,
    input [1:0] S,
    input [3:0] D
    );
    
    wire mid1, mid2;
    m21 m0(.D0(D[0]), .D1(D[1]), .S(S[0]), .Y(mid1));
    m21 m1(.D0(D[2]), .D1(D[3]), .S(S[0]), .Y(mid2));
    m21 m2(.D0(mid1), .D1(mid2), .S(S[1]), .Y(Y));
    
endmodule
