`timescale 1ns / 1ps

module addbit(

    input A,
    input B,
    input cin,
    output sum,
    output cout 
    
    );
    
    wire andAB, xorAB, c1; // intermediates
    
    and(andAB, A, B);
    
    xor(xorAB, A, B);
    xor(sum, xorAB, cin);
    
    and(c1, cin, xorAB);
    or(cout, c1, andAB);
endmodule
