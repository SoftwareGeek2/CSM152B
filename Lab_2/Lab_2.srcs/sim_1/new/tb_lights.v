`timescale 1ns / 1ps


module tb_lights;
    reg clk;
    reg rst;
    reg walk;
    reg traffic;
    wire [2:0] next_state;
    wire [4:0] clk_counter;
    
    
    streetlights uut(.rst(rst), .clk(clk), .walk(walk), .traffic(traffic), .next_state(next_state), .clk_counter(clk_counter));

    
//    wire fast_clk;
//    wire one_sec_clk;
//    wire two_sec_clk;
//    wire three_sec_clk;
//    wire six_sec_clk;
//    wire twelve_sec_clk;
//    wire btn_clk;
    
    
    
//    clock_manager yep_clock (
//            .clk(clk),
//            .fast_clk(fast_clk),
//            .one_sec_clk(one_sec_clk),
//            .two_sec_clk(two_sec_clk),
//            .three_sec_clk(three_sec_clk),
//            .six_sec_clk(six_sec_clk),
//            .twelve_sec_clk(twelve_sec_clk),
//            .btn_clk(btn_clk)
//        );
    
    
    
    
    always #5 clk = ~clk;
    
    initial begin
    
          
          //next_state = 3'b000;
          traffic = 0;
          walk = 0;
          #100000
          
           traffic = 0;
           walk = 0;
           #100000
           
           traffic = 0;
           walk = 0;
           #100000
             
            traffic = 0;
            walk = 0;
            #100000
            
            traffic = 0;
            walk = 0;
            #100000

            traffic = 0;
            walk = 0;
            #100000
            
            traffic = 0;
            walk = 0;
            #100000
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