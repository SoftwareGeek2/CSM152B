`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
 
 
//parameter fastHz = 200000;    // these numbers should be (100MHz/2)/(desired Hz) (250 hz = 200,000)
//parameter oneHz = 50000000;   // 50,000,000
//parameter btnHz = 6250000; // 32 hz 3125000
module clock_manager(
    // Outputs
    output fast_clk,
    output one_sec_clk,
    output two_sec_clk,
    output three_sec_clk,
    output six_sec_clk,
    output twelve_sec_clk,
    output btn_clk,
    // Inputs
    input clk,
    input reset_clk
    
    );
 
`include "clock_definitions.v"
 
reg [25:0] clk_div_fast;
reg [25:0] clk_div_one; //26 bits to get to 50 million
reg [26:0] clk_div_two;
reg [27:0] clk_div_three;
reg [28:0] clk_div_six;
reg [29:0] clk_div_twelve;
reg [25:0] clk_div_btn;
 
reg fast_clk_reg;
reg one_sec_clk_reg;
reg two_sec_clk_reg;
reg three_sec_clk_reg;
reg six_sec_clk_reg;
reg twelve_sec_clk_reg;
reg btn_clk_reg;
 
initial begin
    clk_div_fast = 1;
    clk_div_two = 1;
    clk_div_three = 1;
    clk_div_six = 1;
    clk_div_twelve = 1;
    clk_div_btn = 1;
    clk_div_one = 1;
 
    fast_clk_reg = 0;
    one_sec_clk_reg = 0;
    two_sec_clk_reg = 0;
    three_sec_clk_reg = 0;
    six_sec_clk_reg = 0;
    twelve_sec_clk_reg = 0;
    btn_clk_reg = 0;
end
 
// 1 Hz Clock Divider
always @(posedge clk) begin
    if (clk_div_fast == fastHz) begin
        fast_clk_reg <= ~fast_clk_reg;
        clk_div_fast <= 1;
    end else begin
        clk_div_fast <= clk_div_fast + 1;
    end

    if (clk_div_one == oneHz) begin
        one_sec_clk_reg <= ~one_sec_clk_reg;
        clk_div_one <= 1;
    end else begin
        clk_div_one <= clk_div_one + 1;
    end
    
    if (clk_div_two == oneHz * 2) begin
        two_sec_clk_reg <= ~two_sec_clk_reg;
        clk_div_two <= 1;
    end else begin
        clk_div_two <= clk_div_two + 1;
    end
 
    if (clk_div_three == oneHz * 3) begin
        three_sec_clk_reg <= ~three_sec_clk_reg;
        clk_div_three <= 1;
    end else begin
        clk_div_three <= clk_div_three + 1;
    end
    
    if (clk_div_six == oneHz * 6) begin
        six_sec_clk_reg <= ~six_sec_clk_reg;
        clk_div_six <= 1;
    end else begin
        clk_div_six <= clk_div_six + 1;
    end
    
    if (clk_div_twelve == oneHz * 12) begin
        twelve_sec_clk_reg <= ~twelve_sec_clk_reg;
        clk_div_twelve <= 1;
    end else begin
        clk_div_twelve <= clk_div_twelve + 1;
    end      
    
    if (clk_div_btn == btnHz) begin // clock for button debouncing
        btn_clk_reg <= ~btn_clk_reg;
        clk_div_btn <= 1;
    end else begin
        clk_div_btn <= clk_div_btn + 1;
    end    
  
   
end
 
assign two_sec_clk = two_sec_clk_reg;
assign three_sec_clk = three_sec_clk_reg;
assign six_sec_clk = six_sec_clk_reg;
assign twelve_sec_clk = twelve_sec_clk_reg;
assign btn_clk = btn_clk_reg;
 
endmodule