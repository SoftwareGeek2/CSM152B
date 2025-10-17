`timescale 1ns / 1ps



module reg_file(
    input clock,
    input rst,
    input wire [15:0] busW,
    input wire [4:0] Ra, Rb, Rw,
    input WrEn,
    output reg [15:0] busA, busB 
    );
    
    reg [511:0] regs;
    reg [15:0] tempA,tempB, tempW;


    always @(posedge clock) begin
        if (rst) begin
            regs = {512{1'b0}};
        end else begin
            tempA = ((Ra+1)*16)-1;
            tempB = ((Rb+1)*16)-1;
            tempW = ((Rw+1)*16)-1;
            //regs{tempA:(tempA-15)}
            if (WrEn) begin
                regs[tempW -: 16] = busW;
            end
            if (Ra) begin
                busA = regs[tempA -: 16];
            end 
            if (Rb) begin
                busB = regs[tempB -: 16];
            end
        end
        
            
    end
    
endmodule
