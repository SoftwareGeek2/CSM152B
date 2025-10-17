module sixteen_bit_alu(
  input        clock,          // unused in combinational version
  input  wire [15:0] A,
  input  wire [15:0] B,
  input         Cin,
  input  [3:0]  S,
  output        Cout,
  output [15:0] Y,
  output zero_Out
);
  //reg [255:0] final_result;
  wire [15:0] sub, add, bit_or, bit_and, dec, inc, invert, invert_b, asl, asr, lsl, lsr, slte, slte_helper;
  wire [15:0] filler_1, filler_2, filler_3;
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
  assign   asr     = {A[15], A[15:1]}; //Can we do this?


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
  
  // invert (-B = ~B + 1)
    // First - invert (~B)
    wire [15:0] notB; // ~B
    wire neg_carry_B; // carryout for invert (doubt needed, but just incase)
    genvar neg;
    generate
      for(i = 0; i<16; i=i+1) begin: negate_loop_B
          not(notB[i],B[i]);
      end
    endgenerate
    
    // Second - add 1 (~B + 1)
    adder_16bit neg_add_B (.r1(notB), .r2(16'b0), .ci(1'b1), .carry(neg_carry), .result(invert_b));
    
    //Now invert Cin WRONG (Causes extra +1)
    //wire notCin;
    //not(notCin, Cin);
    wire carry_sub_raw; //Use this to carry notCin //Just Cin actually
    adder_16bit find_sub (.r1(A), .r2(invert_b), .ci(Cin), .carry(carry_sub_raw), .result(sub));


  wire signed [15:0] As = A;

//  wire [16:0] add_ext = {1'b0, A} + {1'b0, B} + Cin;
//  assign Cout = (S == 4'dX /*  ADD code */) ? add_ext[16] : 1'b0;
  
  generate
        for(i = 0; i<16; i=i+1) begin: bitwise_OR
            or(bit_or[i], A[i], B[i]);
        end
  endgenerate
  
  generate
        for(i = 0; i<16; i=i+1) begin: bitwise_AND
            and(bit_and[i], A[i], B[i]);
        end
  endgenerate
  
  //DECREMENT
    adder_16bit decrement (.r1(A), .r2(16'b1111_1111_1111_1111), .ci(1'b0), .carry(Cout), .result(dec));
    
  //INCREMENT
  adder_16bit increment (.r1(A), .r2(16'b1), .ci(1'b0), .carry(Cout), .result(inc));
  
  //SLTE
//  adder_16bit slte_help (.r1(sub), .r2(16'b1111_1111_1111_1111), .ci(1'b0), .carry(Cout), .result(slte_helper));
//  generate
//    for(i=0; i<16; i=i+1) begin: gen_SLTE
//        or(slte[i], slte_helper[15], 1'b0);
//    end
//  endgenerate

//  // --- overflow-correct SLTE: flip SLTE if subtraction overflowed ---
//  // V = (A ^ B) & (A ^ sub)
//  wire axb, axs, V;
//  xor (axb, A[15], B[15]);
//  xor (axs, A[15], sub[15]);
//  and (V, axb, axs);
  
//  // slte_fixed = slte ^ {16{V}}  (bitwise negate SLTE when V=1)
//  wire [15:0] slte_fixed;
//  generate
//    for (i = 0; i < 16; i = i + 1) begin : GEN_SLTE_OVERFLOW_FIX
//       xor (slte_fixed[i], slte[i], V);
//    end
//  endgenerate

    // --- SLTE (A <= B?) Use SUB with overflow correction ---
    // V = (A ? B) & (A ? sub)
    wire axb, axs, V;
    xor (axb, A[15], B[15]);
    xor (axs, A[15], sub[15]);
    and (V,   axb,   axs); //V = 1 iff overflow occured
    
    // Was the result of the subtraction 0?
    wire [15:0] or_acc;
    
    or (or_acc[0], sub[0], 1'b0);   // seed: or_acc[0] = sub[0]
    genvar z;
    generate
      for (z = 1; z < 16; z = z + 1) begin : Ripple_OR
        or (or_acc[z], or_acc[z-1], sub[z]); // Ripple carry the result of the OR
      end
    endgenerate
    
    wire zero_sub;
    not (zero_sub, or_acc[15]);     // zero_sub = 1 iff sub == 0
    or(zero, zero_sub, 0);
    
    
    
    // slte_scalar = (sub[15] | zero_sub) ? V
    wire sub_msb_or_zero, slte_scalar;
    or  (sub_msb_or_zero, sub[15], zero_sub);
    xor (slte_scalar,     sub_msb_or_zero, V);
    generate
      for (z = 0; z < 16; z = z + 1) begin : Set_SLTE
        or (slte[z], slte_scalar, 1'b0);
    end
    endgenerate//{16{slte_scalar}}
  // Flattened-bus 16:1 mux
  m161 mux_alu (
    .D({asr, filler_3, asl, filler_2, lsr, slte, lsl, filler_1, invert, inc, dec, bit_and, bit_or, add, sub}),//Order is important
    .S(S),
    .Y(Y)
  );
  
 wire [15:0] nY;
 wire [14:0] and_chain;
 genvar k;
 generate
    for(k=0; k<16;k = k+1) begin
        not(nY[k], Y[k]);
    end
 endgenerate//nY = ALL 1's
  
  and (and_chain[0], nY[0], nY[1]);   
  generate
    for (k = 1; k < 15; k = k + 1) begin : Set_KBit
      and (and_chain[k], and_chain[k-1], nY[k+1]); // Ripple carry the result of the AND
    end
  endgenerate
  
  and (zero_Out, and_chain[14], 1'b1);
  
//  or(zero_Out, zero_help[15], 0);
  
  //not (zero_sub, or_acc[15]);     // zero_sub = 1 iff sub == 0
  //or(zero, zero_sub, 0);
 
  
endmodule
