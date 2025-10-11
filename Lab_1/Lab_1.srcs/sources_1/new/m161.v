`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2025 01:31:33 PM
// Design Name: 
// Module Name: m161
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


/**

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
*/

module m161(

    input clock,
    output [15:0] Y,
    input [3:0] S,
    input [255:0] D
    );
    
    wire [63:0] mid;
    
    m41_16 m0(.clock(clock), .D(D[63:0]), .S(S[1:0]), .Y(mid[15:0]));
    m41_16 m1(.clock(clock), .D(D[127:64]), .S(S[1:0]), .Y(mid[31:16]));
    m41_16 m2(.clock(clock), .D(D[191:128]), .S(S[1:0]), .Y(mid[47:32]));
    m41_16 m3(.clock(clock), .D(D[255:192]), .S(S[1:0]), .Y(mid[63:48]));
    
    m41_16 m5(.clock(clock), .D(mid), .S(S[3:2]), .Y(Y));
    
    
    
    
endmodule
