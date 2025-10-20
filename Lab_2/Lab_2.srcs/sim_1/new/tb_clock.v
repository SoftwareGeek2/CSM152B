`timescale 1ns / 1ps

module tb_clock;

    reg clk;
    wire one_hz_clk;
    wire fast_hz_clk;
    wire btn_hz_clk;
    
    
    clock_manager uut (
        .clk(clk),
        .one_hz_clk(one_hz_clk),
        .fast_hz_clk(fast_hz_clk),
        .btn_hz_clk(btn_hz_clk)
    );
    
    initial begin
        clk = 0;
        
        forever #10 clk = ~clk;
    end
endmodule
