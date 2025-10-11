`timescale 1ns / 1ps


module tb;
    reg clock;
    
    
    /**
    reg [3:0] r1;
    reg [3:0] r2;
    reg ci; // carry in
    wire [3:0] result;
    wire carry; // carry out
    
    adder_explicit uut(
        .r1(r1),
        .r2(r2),
        .ci(ci), // carry in
        .result(result),
        .carry(carry) // carry out
    );
    */
    
    // --- 16:1 16-bit MUX test signals ---
    reg  [255:0] D256;
    reg  [3:0]   S16;
    wire [15:0]  Y16;
    function [15:0] lane16;
        input [255:0] bus;
        input [3:0]   idx;
        begin
            lane16 = bus[16*idx +: 16];
        end
    endfunction

    integer trial, sel;

    // DUT: 16:1 mux of 16-bit lanes
    m161 uut_mux16 (
        .clock(clock),
        .D(D256),
        .S(S16),
        .Y(Y16)
    );

//    wire Y;
//    wire Cout;
//    reg [1:0] S;
//    reg [3:0] D;
//    reg A, B, Cin;
//    integer i;

//    m41 uut(
//        .clock(clock),
//        .S(S),
//        .D(D),
//        .Y(Y)
//    );
    
//    one_bit_alu uut(
//        .clock(clock),
//        .A(A),
//        .B(B),
//        .Cin(Cin),
//        .S(S),
////        .D(D),  // .D({sum, orAB, andAB, notA})
//        .Y(Y),
//        .Cout(Cout)
//    );
    //4bit adder test
    
    
    initial begin
            clock = 0;
            
            
            
            
//            4:1 MUX TEST
//            S = 2'b11;
//            D = 4'b0000; // d3d2d1d0 - d1d0 - m1, d3d2 - m2
//            for (i = 0; i < 16; i = i+1) begin
//                #10 D = D + 1; 
//            end


//            #10 // NOT test
//            S = 2'b00; // Not gate
//            A = 1;
//            B = 1;
//            #10    
//            A = 0;
            
//            #10 // AND test
//            S= 2'b01; // AND gate
//            A=0;
//            B=0;
//            #10
//            A=0;
//            B=1;
//            #10
//            A=1;
//            B=0;     
//            #10
//            A=1;
//            B=1;   
            
//            #10 // OR test
//            S= 2'b10; // AND gate
//            A=0;
//            B=0;
//            #10
//            A=0;
//            B=1;
//            #10
//            A=1;
//            B=0;     
//            #10
//            A=1;
//            B=1;   
            
//            #10 // FULL ADDER CIN=0 test
//            S= 2'b11; // AND gate
//            Cin = 0;
//            A=0;
//            B=0;
//            #10
//            A=0;
//            B=1;
//            #10
//            A=1;
//            B=0;     
//            #10
//            A=1;
//            B=1;  
            
//            #10 // FULL ADDER CIN =1 
//            Cin = 1;
//            A=0;
//            B=0;
//            #10
//            A=0;
//            B=1;
//            #10
//            A=1;
//            B=0;     
//            #10
//            A=1;
//            B=1; 
//            #10 

            // ---- 16:1 16-bit MUX SANITY TEST (quiet; only prints on failure) ----
            // Golden model helper: pick the k-th 16-bit lane from a 256-bit bus

            // ---- 16:1 16-bit MUX SANITY TEST (add display of actual vs expected) ----
            // Fill random lanes and sweep all selects
            for (trial = 0; trial < 50; trial = trial + 1) begin
                // load 16 lanes with random 16-bit words
                for (sel = 0; sel < 16; sel = sel + 1)
                    D256[16*sel +: 16] = $random;

                // sweep S16 across all 16 choices
                for (sel = 0; sel < 16; sel = sel + 1) begin
                    S16 = sel[3:0]; #1;  // small delta for propagation
                    if (Y16 !== lane16(D256, S16)) begin
                        $display("FAIL m161 trial=%0d S=%0d exp=%h got=%h",
                                 trial, S16, lane16(D256, S16), Y16);
                    end
                    else if (trial == 0) begin
                        // Fresh display showing that the MUX output matches expected (first trial only to avoid spam)
                        $display("OK   m161 S=%0d Y=%h exp=%h",
                                 S16, Y16, lane16(D256, S16));
                    end
                end
            end
            
            
            
                               
                       
            $finish;
        end  

endmodule