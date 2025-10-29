`timescale 1ns / 1ps


module tb_lights;
    reg clk = 0;
    wire fast_clk;
    reg rst;
    reg walk;
    reg traffic;
    wire [2:0] next_state;
    wire [4:0] clk_counter;
    
    
    
    
    streetlights uut(.rst(rst), .clk(clk), .fast_clk(fast_clk), .walk(walk), .traffic(traffic), .next_state(next_state), .clk_counter(clk_counter));
    
    
    always #5 clk = ~clk;
    
    initial begin
    
          
          //next_state = 3'b000;
          rst = 0;
          traffic = 0;
          walk = 0;
          #2_200_000 // first 6 cycle
          traffic = 1;
          #200_000
           #400_000
           rst = 1;
           
           #2_400_000
           rst = 0;
           walk = 1;
           traffic = 0;
           
           #2_400_000 // state 001 end
           
           #800_000 // state 011 end
           
           #1_200_000 // state 100 end
           
           walk = 0;
            #50000000
            $finish;                                    
    end
    
    
    
endmodule
//module streetlights(
//    input clk,
//    input rst,
//    input wire walk,
//    input traffic,
//    output reg walk_active,
//    output reg [2:0] next_state,
//    output reg [4:0] clk_counter = 0
//    );