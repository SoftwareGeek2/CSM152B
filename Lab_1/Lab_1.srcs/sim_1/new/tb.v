`timescale 1ns / 1ps


module tb;
    reg clock;
    wire Y;
    wire Cout;
    reg [1:0] S;
    reg [3:0] D;
    reg A, B, Cin;
    integer i;
    
//    m41 uut(
//        .clock(clock),
//        .S(S),
//        .D(D),
//        .Y(Y)
//    );
    
    one_bit_alu uut(
        .clock(clock),
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
//        .D(D),  // .D({sum, orAB, andAB, notA})
        .Y(Y),
        .Cout(Cout)
    );
    
    initial begin
            clock = 0;
//            S = 2'b11;
//            D = 4'b0000; // d3d2d1d0 - d1d0 - m1, d3d2 - m2
//            for (i = 0; i < 16; i = i+1) begin
//                #10 D = D + 1; 
//            end
            #10 // NOT test
            S = 2'b00; // Not gate
            A = 1;
            B = 1;
            #10    
            A = 0;
            
            #10 // AND test
            S= 2'b01; // AND gate
            A=0;
            B=0;
            #10
            A=0;
            B=1;
            #10
            A=1;
            B=0;     
            #10
            A=1;
            B=1;   
            
            #10 // OR test
            S= 2'b10; // AND gate
            A=0;
            B=0;
            #10
            A=0;
            B=1;
            #10
            A=1;
            B=0;     
            #10
            A=1;
            B=1;   
            
            #10 // FULL ADDER CIN=0 test
            S= 2'b11; // AND gate
            Cin = 0;
            A=0;
            B=0;
            #10
            A=0;
            B=1;
            #10
            A=1;
            B=0;     
            #10
            A=1;
            B=1;  
            
            #10 // FULL ADDER CIN =1 
            Cin = 1;
            A=0;
            B=0;
            #10
            A=0;
            B=1;
            #10
            A=1;
            B=0;     
            #10
            A=1;
            B=1; 
            #10 
            
            
            
                               
                       
            $finish;
        end  

endmodule
