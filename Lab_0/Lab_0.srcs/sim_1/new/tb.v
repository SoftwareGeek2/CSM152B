`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2025 11:10:15 AM
// Design Name: 
// Module Name: tb
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
 
 
module tb;
    reg clock;
    reg reset;
    reg enable;
    wire [3:0] counter_out;
 
    counter uut(
        .clock(clock),
        .reset(reset),
        .enable(enable),
        .counter_out(counter_out)
    );
 
    initial begin
        enable = 0;
        reset = 0;
        clock = 0;
        # 10
        clock = 1;
        # 10
        enable = 1;
        clock = 0; // Start counting from here
        # 10
        clock = 1;
        # 10
        clock = 0;
        # 10
        clock = 1;
        # 10
        clock = 0;
        # 10
        clock = 1;
        # 10
        clock = 0;
        # 10
        clock = 1; // Should be 4
        # 10
        clock = 0;
        # 10
        clock = 1;
        # 10
        clock = 0;
        # 10
        clock = 1;
        # 10
        clock = 0;
        # 10
        clock = 1; // Should be 8
        # 10
        clock = 0;
        # 10
        clock = 1;
        # 10
        clock = 0;
        # 10
        clock = 1;
        # 10
        clock = 0;
        # 10
        clock = 1; // Should be 12
        # 10
        clock = 0;
        # 10
        clock = 1;
        # 10
        clock = 0;
        # 10
        clock = 1;
        # 10
        reset = 1;
        clock = 0;
        # 10
        clock = 1;
        # 10
        clock = 0;
        reset = 0; // Reset to 0 here
        # 10
        clock = 1; // Should be 1
        # 10                               
        $finish;                                
 
    end
endmodule