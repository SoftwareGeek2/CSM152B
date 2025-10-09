`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2025 08:42:30 AM
// Design Name: 
// Module Name: counter
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


module counter(
    input clock,
    input reset,
    input enable,
    output reg [3:0] counter_out
);

    initial begin
        counter_out = 4'b0000; // Other initialization only for always blocks
    end

    always @(posedge clock) begin
        if (reset) begin
            counter_out <= 4'b0000;
        end
        else if (enable) begin
            counter_out <= counter_out + 1;
        end
    end

endmodule

