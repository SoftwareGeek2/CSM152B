// tb_reg.v
`timescale 1ns / 1ps

module tb_reg;

  // DUT I/O
  reg         clock;
  reg         rst;
  reg  [15:0] busW;
  reg  [4:0]  Ra, Rb, Rw;
  reg         WrEn;
  wire [15:0] busA, busB;

  // 512-bit test pattern (32 x 16-bit lanes: lane 0 is [15:0], lane 31 is [511:496])
  // You'll see these exact values show up on busA/busB when addressed.
  localparam [511:0] DATA512 = {
    16'hDEAD,16'hBEEF,16'hC001,16'hD00D,16'h1234,16'h5678,16'h9ABC,16'hDEF0,
    16'h0F0F,16'hF0F0,16'hAAAA,16'h5555,16'h1357,16'h2468,16'hFACE,16'hB00C,
    16'h1111,16'h2222,16'h3333,16'h4444,16'h5555,16'h6666,16'h7777,16'h8888,
    16'h9999,16'hAAAA,16'hBBBB,16'hCCCC,16'hDDDD,16'hEEEE,16'hFFFF,16'h0000
  };

  // Device under test
  reg_file dut (
    .clock(clock),
    .rst(rst),
    .busW(busW),
    .Ra(Ra), .Rb(Rb), .Rw(Rw),
    .WrEn(WrEn),
    .busA(busA), .busB(busB)
  );

  // 100 MHz clock (10 ns period)
  initial clock = 1'b0;
  always #5 clock = ~clock;

  initial begin
    // ----------------------------------------------------------------
    // Reset the file (regs must go to 0)
    // ----------------------------------------------------------------
    // Set inputs (don't care for read ports during reset)
    rst  = 1'b1;
    WrEn = 1'b0;
    Rw   = 5'd0;
    Ra   = 5'd0;
    Rb   = 5'd0;
    busW = 16'h0000;
    // Expectation: after this rising edge, internal regs are cleared to 0
    #12;  // cross a posedge while rst=1

    // Deassert reset
    rst = 1'b0;
    #10;

    // ----------------------------------------------------------------
    // WRITE R1 with DATA512[31:16] then READ it on A
    // ----------------------------------------------------------------
    // Values: Rw=1, busW = DATA512 lane 1 = DATA512[31:16]
    WrEn = 1'b1; Rw = 5'd1; busW = DATA512[31:16]; Ra = 5'd0; Rb = 5'd0;
    // Result after next posedge: regs[1] = DATA512[31:16]
    #10;

    // Values: Ra=1 (read back R1 on port A), WrEn=0
    WrEn = 1'b0; Ra = 5'd1; Rb = 5'd0;
    // Result after next posedge: busA = DATA512[31:16]
    #10;

    // ----------------------------------------------------------------
    // EDGE CASE: Concurrent WRITE/READ same register on A (must see NEW value)
    // ----------------------------------------------------------------
    // Values: Rw=2, busW = DATA512[47:32]; Ra=2 (same reg), WrEn=1
    WrEn = 1'b1; Rw = 5'd2; busW = DATA512[47:32]; Ra = 5'd2; Rb = 5'd0;
    // Result after next posedge: busA = DATA512[47:32] (newly written value)
    #10;

    // ----------------------------------------------------------------
    // EDGE CASE: Concurrent WRITE/READ same register on B (must see NEW value)
    // ----------------------------------------------------------------
    // Values: Rw=3, busW = DATA512[63:48]; Rb=3 (same reg), WrEn=1
    WrEn = 1'b1; Rw = 5'd3; busW = DATA512[63:48]; Ra = 5'd0; Rb = 5'd3;
    // Result after next posedge: busB = DATA512[63:48] (newly written value)
    #10;

    // ----------------------------------------------------------------
    // WRITE R4 while READING a different reg (R1) on A (no hazard)
    // ----------------------------------------------------------------
    // Values: Rw=4, busW = DATA512[79:64]; Ra=1 (already written), WrEn=1
    WrEn = 1'b1; Rw = 5'd4; busW = DATA512[79:64]; Ra = 5'd1; Rb = 5'd0;
    // Result after next posedge: regs[4] updated; busA still = DATA512[31:16]
    #10;

    // ----------------------------------------------------------------
    // READ two different regs simultaneously (A=R2, B=R3)
    // ----------------------------------------------------------------
    // Values: WrEn=0; Ra=2; Rb=3
    WrEn = 1'b0; Ra = 5'd2; Rb = 5'd3;
    // Result after next posedge: busA = DATA512[47:32], busB = DATA512[63:48]
    #10;

    // ----------------------------------------------------------------
    // OVERWRITE R2 with a new literal; read it on BOTH ports
    // ----------------------------------------------------------------
    // Values: Rw=2, busW=16'hA55A; Ra=2; Rb=2; WrEn=1
    WrEn = 1'b1; Rw = 5'd2; busW = 16'hA55A; Ra = 5'd2; Rb = 5'd2;
    // Result after next posedge: busA = busB = 16'hA55A (updated value)
    #10;

    // ----------------------------------------------------------------
    // WRITE a higher register (R10) from DATA512 and then READ it
    // ----------------------------------------------------------------
    // Values: Rw=10, busW = DATA512[175:160]; WrEn=1
    WrEn = 1'b1; Rw = 5'd10; busW = DATA512[175:160]; Ra = 5'd0; Rb = 5'd0;
    // Result after next posedge: regs[10] updated
    #10;

    // Values: Ra=10 (read back R10)
    WrEn = 1'b0; Ra = 5'd10; Rb = 5'd0;
    // Result after next posedge: busA = DATA512[175:160]
    #10;

    // ----------------------------------------------------------------
    // WRITE the last register (R31) and read it on B
    // ----------------------------------------------------------------
    // Values: Rw=31, busW = DATA512[511:496]; WrEn=1
    WrEn = 1'b1; Rw = 5'd31; busW = DATA512[511:496]; Ra = 5'd0; Rb = 5'd0;
    // Result after next posedge: regs[31] updated
    #10;

    // Values: Rb=31 (read back R31 on port B)
    WrEn = 1'b0; Ra = 5'd0; Rb = 5'd31;
    // Result after next posedge: busB = DATA512[511:496]
    #10;

    // ----------------------------------------------------------------
    // Concurrent WRITE R5 while reading R4 on B (independent ports)
    // ----------------------------------------------------------------
    // Values: Rw=5, busW = DATA512[95:80]; Rb=4 (previously written); WrEn=1
    WrEn = 1'b1; Rw = 5'd5; busW = DATA512[95:80]; Ra = 5'd0; Rb = 5'd4;
    // Result after next posedge: regs[5] updated; busB remains = DATA512[79:64]
    #10;

    // ----------------------------------------------------------------
    // READ two different regs again (A=R5 new, B=R4 old)
    // ----------------------------------------------------------------
    // Values: WrEn=0; Ra=5; Rb=4
    WrEn = 1'b0; Ra = 5'd5; Rb = 5'd4;
    // Result after next posedge: busA = DATA512[95:80]; busB = DATA512[79:64]
    #10;

    // ----------------------------------------------------------------
    // EDGE CASE (repeat on B): Concurrent WRITE/READ same reg (R10) on B
    // ----------------------------------------------------------------
    // Values: Rw=10, busW = 16'h55AA; Rb=10 (same reg), WrEn=1
    WrEn = 1'b1; Rw = 5'd10; busW = 16'h55AA; Ra = 5'd0; Rb = 5'd10;
    // Result after next posedge: busB = 16'h55AA (newly written value)
    #10;

    // Done
    #10;
    $finish;
  end

endmodule