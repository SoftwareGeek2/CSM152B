`timescale 1ns / 1ps


module m21_16(
    output [15:0] Y,
    input [15:0] D0, D1, 
    input S
    
    
);

wire [15:0] T1, T2;

genvar i;
generate
    for(i = 0; i<16; i = i+1) begin: mux_loop
        m21 genloop(.D0(D0[i]), .D1(D1[i]), .S(S), .Y(Y[i])
        );
        end
    
endgenerate
endmodule
