`timescale 1ns / 1ps

module tb_clock;

    reg clk;
    wire two_sec_clk;
    wire three_sec_clk;
    wire six_sec_clk;
    wire twelve_sec_clk;
    wire btn_clk;
    
    
    clock_manager uut (
        .clk(clk),
        .two_sec_clk(two_sec_clk),
        .three_sec_clk(three_sec_clk),
        .six_sec_clk(six_sec_clk),
        .twelve_sec_clk(twelve_sec_clk),
        .btn_clk(btn_clk)
    );
    
    initial begin
        clk = 0;
        
        forever #10 clk = ~clk;
    end
endmodule
