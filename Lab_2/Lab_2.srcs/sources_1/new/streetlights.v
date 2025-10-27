`timescale 1ns / 1ps
module streetlights(
    input clk,
    input rst,
    input wire walk,
    input traffic,
    output reg walk_active,
    output reg [2:0] next_state,
    output reg [4:0] clk_counter = 0,
    output reg [6:0] led
    );
    
    wire fast_clk;
    wire one_sec_clk;
    wire two_sec_clk;
    wire three_sec_clk;
    wire six_sec_clk;
    wire twelve_sec_clk;
    wire btn_clk;
    
    
    reg [2:0] next_state;
    reg [4:0] clk_counter = 0;
    reg walk_latched = 0;
    
   
    
    clock_manager yep_clock (
        .clk(clk),
        .fast_clk(fast_clk),
        .one_sec_clk(one_sec_clk),
        .two_sec_clk(two_sec_clk),
        .three_sec_clk(three_sec_clk),
        .six_sec_clk(six_sec_clk),
        .twelve_sec_clk(twelve_sec_clk),
        .btn_clk(btn_clk)
    );
    
    always @(posedge one_sec_clk or posedge rst) begin
        if (rst) begin
            walk_latched <= 0;
        end
        else if (walk)
            walk_latched <= 1;   // button pressed
        else if (next_state == 3'b100 && clk_counter == 3)
            walk_latched <= 0;   // clear after walk phase
    end
        
        
    always @(posedge fast_clk) begin
        if (rst) begin
            next_state <= 3'b000;
            clk_counter <= 0;
            walk_active <= 0;
        end else begin
            case(next_state)
                3'b000: begin
                    // main green
                    // side red
                    led = 7'b001_0_001;
                    if (clk_counter == 6) begin
                        if (traffic) begin                            
                            next_state = 3'b010;
                        end else begin
                            next_state = 3'b001;
                        end
                        clk_counter = 0;
                    end else begin
                        clk_counter = clk_counter + 1;
                    end
                end
                3'b001: begin
                    // main green
                    // side red
                    led = 7'b001_0_001;
                    if (clk_counter == 6) begin
                        next_state = 3'b011;
                        clk_counter = 0;
                    end else begin
                        clk_counter = clk_counter + 1;
                    end
                end
                3'b010: begin
                    // main green
                    // side red
                    led = 7'b001_0_001;
                    if (clk_counter == 3) begin
                        next_state = 3'b011;
                        clk_counter = 0;
                    end else begin
                        clk_counter = clk_counter + 1;
                    end
                end
                3'b011: begin
                    // main yellow
                    // side red
                    led = 7'b010_0_001;
                    if (clk_counter == 2) begin
                        if (walk_latched) begin                            
                                next_state = 3'b100;
                            end else begin
                                next_state = 3'b101;
                            end
                        clk_counter = 0;
                    end else begin
                        clk_counter = clk_counter + 1;
                    end
                end
                3'b100:  begin
                   // main red
                   // side red
                   // walk on
                   led = 7'b100_1_001;
                  walk_active <= 1'b1;
                   if (clk_counter == 3) begin
                       next_state = 3'b101;
                       // walk cleared in prior always
                       clk_counter = 0;
                   end else begin
                       clk_counter = clk_counter + 1;
                   end
               end
                3'b101: begin
                   // main red
                   // side green
                   // walk off
                   led = 7'b100_0_100;
                   walk_active <= 1'b0;
                   if (clk_counter == 6) begin
                       if (traffic) begin                            
                           next_state = 3'b110;
                       end else begin
                           next_state = 3'b111;
                       end
                       clk_counter = 0;
                   end else begin
                       clk_counter = clk_counter + 1;
                   end
               end
                3'b110: begin
                   // main red
                   // side green
                   led = 7'b100_1_100;
                   if (clk_counter == 3) begin
                       next_state = 3'b011;
                       clk_counter = 0;
                   end else begin
                       clk_counter = clk_counter + 1;
                   end
               end
                3'b111: begin
                   // main red
                   // side yellow
                   led = 7'b100_1_010;
                   if (clk_counter == 2) begin
                       next_state = 3'b000;
                       clk_counter = 0;
                   end else begin
                       clk_counter = clk_counter + 1;
                   end
               end
           endcase
        end
    end
    
    
    
endmodule
