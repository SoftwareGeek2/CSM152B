module sixteen_bit_alu(
  input        clock,          // unused in combinational version
  input  wire [15:0] A,
  input  wire [15:0] B,
  input         Cin,
  input  [3:0]  S,
  output        Cout,
  output [15:0] Y
);
  //reg [255:0] final_result;
  wire [15:0] sub, add, bit_or, bit_and, dec, inc, invert, asl, asr, lsl, lsr;

//  assign add     = A + B + Cin;
//  assign sub     = A - B - Cin;
//  assign bit_or  = A | B;
//  assign bit_and = A & B;
//  assign inc     = A + 16'd1;
//  assign dec     = A - 16'd1;
//  assign invert  = ~A;
  
  assign lsl     = {A[14:0],1'b0};
  assign asl  = {A[14:0],1'b0};
  assign   lsr     = {1'b0, A[14:0]};
  assign   asr     = {A[15], A[15:1]};


  // adder  
  adder_16bit find_sum (.r1(A), .r2(B), .ci(Cin), .carry(Cout), .result(add));

  // invert (-A = ~A + 1)
  // First - invert (~A)
  wire [15:0] notA; // ~A
  wire neg_carry; // carryout for invert (doubt needed, but just incase)
  genvar i;
  generate
    for(i = 0; i<16; i=i+1) begin: negate_loop
        not(notA[i],A[i]);
    end
  endgenerate
  
  // Second - add 1 (~A + 1)
  adder_16bit neg_add (.r1(notA), .r2(16'b0), .ci(1'b1), .carry(neg_carry), .result(invert));


  wire signed [15:0] As = A;

  wire [16:0] add_ext = {1'b0, A} + {1'b0, B} + Cin;
  assign Cout = (S == 4'dX /*  ADD code */) ? add_ext[16] : 1'b0;

  // Flattened-bus 16:1 mux
  m161 #(.W(16), .N(11)) mux_alu (
    .D({lsr, lsl, asr, asl, invert, inc, dec, bit_and, bit_or, add, sub}),//Order is important
    .S(S),
    .Y(Y)
  );
endmodule
