`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2025 11:27:55 AM
// Design Name: 
// Module Name: addbit
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
