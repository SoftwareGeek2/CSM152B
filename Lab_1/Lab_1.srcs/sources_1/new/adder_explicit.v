`timescale 1ns / 1ps

// 4 bit adder (provided)
module adder_explicit(
    input [3:0] r1,
    input [3:0] r2,
    input ci, // carry in
    output [3:0] result,
    output carry // carry out
    
    );
    
    wire c1, c2, c3; //carry-out intermediates
    
    addbit u0 (.A(r1[0]), .B(r2[0]), .cin(ci), .sum(result[0]), .cout(c1));
    addbit u1 (.A(r1[1]), .B(r2[1]), .cin(c1), .sum(result[1]), .cout(c2));
    addbit u2 (.A(r1[2]), .B(r2[2]), .cin(c2), .sum(result[2]), .cout(c3));
    addbit u3 (.A(r1[3]), .B(r2[3]), .cin(c3), .sum(result[3]), .cout(carry));
endmodule
