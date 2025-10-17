`timescale 1ns / 1ps


module tb;
    reg clock;
    
    reg  [15:0] A;
    reg  [15:0] B;
    reg         Cin;
    reg  [3:0]  S;
    wire        Cout;
    wire [15:0] Y;
    
    
    
//    reg [15:0] r1;
//    reg [15:0] r2;
//    reg ci; // carry in
//    wire [15:0] result;
//    wire carry; // carry out
    
    
    sixteen_bit_alu uut(
        .clock(clock),
        .A(A),
        .B(B),
        .Cin(Cin), // carry in
        .Y(Y),
        .Cout(Cout), // carry out
        .S(S)
    );
    
//    adder_16bit uut(
//        .r1(r1),
//        .r2(r2),
//        .ci(ci), // carry in
//        .result(result),
//        .carry(carry) // carry out
//    );
    
    
//    // --- 16:1 16-bit MUX test signals ---
//    reg  [255:0] D256;
//    reg  [3:0]   S16;
//    wire [15:0]  Y16;
//    function [15:0] lane16;
//        input [255:0] bus;
//        input [3:0]   idx;
//        begin
//            lane16 = bus[16*idx +: 16];
//        end
//    endfunction

//    integer trial, sel;

//    // DUT: 16:1 mux of 16-bit lanes
//    m161 uut_mux16 (
//        .clock(clock),
//        .D(D256),
//        .S(S16),
//        .Y(Y16)
//    );


    //4bit adder test
    
    
    initial begin
            clock = 0;
//            .D({lsr, lsl, asr, asl, invert, inc, dec, bit_and, bit_or, add, sub}),//Order is important
            // ALU 'ADD' TEST
            Cin = 0;
            A = 16'b1000_0000_0000_0000;
            B = 16'b0111_1111_1111_1111;
            S = 4'b0001; //Result : 0xFFFF
            #10//
            
            // ALU 'INVERT' TEST
            A = 16'b1000_0000_0000_0000; // invert is same (0x8000)
            B = 16'b0111_1111_1111_1111; //shouldnt matter
            S = 4'b0110; // 6 -> invert
            #10
            A = 16'b0000_0001_0000_0000; // invert is ff00
            
            #10 //Subtract test
            A = 16'b1000_0000_0000_0000; // 0x8000
            B = 16'b0111_1111_1111_1111; //0x7FFF
            S = 4'b0000; // 0 -> Subtract
            #10//result should be 0x0001
            
            A = 16'b1111_1111_1111_1111; // 
            B = 16'b0111_1111_1111_1111; //
            S = 4'b0000;
            #10//result should be 0x8000      
            
            //Decrement test
            A = 16'b1111_1111_1111_1111; // 
            B = 16'b0111_1111_1111_1111; //
            S = 4'b0100;// Decrement A
            #10//result should be FFFE
            
            A = 16'b1111_1111_1111_1111; //  
            B = 16'b0111_1111_1111_1111; //
            S = 4'b0101;// Increment A
            #10//result should be 0
            
            A = 16'b0111_1111_1111_1111; //
            B = 16'b0011_1111_1111_1111; //
            S = 4'b1001;// SLTE
            #10//should be FALSE (0000_0000_0000_0000)
               
            
            A = 16'b1111_1111_1111_1111; //
            B = 16'b1111_1111_1111_1111; //
            S = 4'b1001;// SLTE
            #10//should be TRUE (1111_1111_1111_1111)
            
            A = 16'b1111_1111_1111_1111; //
            B = 16'b1111_1111_1111_1111; //
            S = 4'b1001;// SLTE
            #10//should be TRUE (1111_1111_1111_1111)
//            ci = 0;
            
//            r1 = 16'b1000_0000_0000_0000;
//            r2 = 16'b0111_1111_1111_1111;
            
//            # 10 


            // ---- 16:1 16-bit MUX SANITY TEST (quiet; only prints on failure) ----
            // Golden model helper: pick the k-th 16-bit lane from a 256-bit bus

            // ---- 16:1 16-bit MUX SANITY TEST (add display of actual vs expected) ----
            // Fill random lanes and sweep all selects
//            for (trial = 0; trial < 50; trial = trial + 1) begin
//                // load 16 lanes with random 16-bit words
//                for (sel = 0; sel < 16; sel = sel + 1)
//                    D256[16*sel +: 16] = $random;

//                // sweep S16 across all 16 choices
//                for (sel = 0; sel < 16; sel = sel + 1) begin
//                    S16 = sel[3:0]; #1;  // small delta for propagation
//                    if (Y16 !== lane16(D256, S16)) begin
//                        $display("FAIL m161 trial=%0d S=%0d exp=%h got=%h",
//                                 trial, S16, lane16(D256, S16), Y16);
//                    end
//                    else if (trial == 0) begin
//                        // Fresh display showing that the MUX output matches expected (first trial only to avoid spam)
//                        $display("OK   m161 S=%0d Y=%h exp=%h",
//                                 S16, Y16, lane16(D256, S16));
//                    end
//                end
//            end
            
            
            
                               
                       
            $finish;
        end  

endmodule