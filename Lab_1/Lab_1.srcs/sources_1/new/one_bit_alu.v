`timescale 1ns / 1ps


module one_bit_alu(
    input clock,
    input A,
    input B,
    input Cin,
    input [1:0] S,
    output Y,
    output Cout 
    
    );
    
    wire notA, andAB, orAB, sum; // end res
    wire xorAB, c1; // intermediates
    
    not(notA, A);
    and(andAB, A, B);
    or(orAB, A, B);
    
    xor(xorAB, A, B);
    xor(sum, xorAB, Cin);
    
    and(c1, Cin, xorAB);
    or(Cout, c1, andAB);
    
    m41 mux_alu (
        .D({sum, orAB, andAB, notA}),
        .S(S),
        .Y(Y)
    );
    
    
    
    
    
    
endmodule
