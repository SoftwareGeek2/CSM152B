`timescale 1ns / 1ps


module tb;
    reg clock;
    wire Y;
    reg [1:0] S;
    reg [3:0] D;
    integer i;
    
    m41 uut(
        .clock(clock),
        .S(S),
        .D(D), 
        .Y(Y)
    );
    
    initial begin
            clock = 0;
            S = 2'b11;
            D = 4'b0000; // d3d2d1d0 - d1d0 - m1, d3d2 - m2
            for (i = 0; i < 16; i = i+1) begin
                #10 D = D + 1; 
            end
            # 10                               
            $finish;
        end  

endmodule
