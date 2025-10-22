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
  wire Cout_add, Cout_sub, Cout_inc, Cout_dec, Cout_asl;//OVERFLOW NOT COUT
  wire [15:0] Cout_add_ar, Cout_sub_ar, Cout_inc_ar, Cout_dec_ar, Cout_asl_ar, Cout_Final_arr;//OVERFLOW NOT COUT
//  assign add     = A + B + Cin;
//  assign sub     = A - B - Cin;
//  assign bit_or  = A | B;
//  assign bit_and = A & B;
//  assign inc     = A + 16'd1;
//  assign dec     = A - 16'd1;
//  assign invert  = ~A;
  
  
  integer b_times;
//  genvar b_times;
//  generate
//      for(b_times = 0; b_times < 16; b_times = b_times+1) begin:copy_B
//          or(filler_1[b_times], B[b_times], 1'b0);
//      end
//  endgenerate
  
//  always @(*) begin
//      for(b_times = 0; b_times<16; b_times = b_times+1) begin:shift_Btimes
//          assign lsl     = {A[14:0],1'b0};
//          assign asl  = {A[14:0],1'b0};
//          assign   lsr     = {1'b0, A[14:0]};
//          assign   asr     = {A[15], A[15:1]}; //Can we do this?
//      end
//  end
    genvar i;
 
    // Logical shift left
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_lsl
            assign lsl[i] = (i >= B) ? A[i - B] : 1'b0;
        end
    endgenerate
 
    // Arithmetic shift left (same as logical for unsigned left shift)
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_asl
            assign asl[i] = (i >= B) ? A[i - B] : 1'b0;
        end
    endgenerate
    
    xor(Cout_asl, asl[15], A[15]);
 
    // Logical shift right
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_lsr
            assign lsr[i] = (i + B < 16) ? A[i + B] : 1'b0;
        end
    endgenerate
 
    // Arithmetic shift right
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_asr
            assign asr[i] = (i + B < 16) ? A[i + B] : A[15];
        end
    endgenerate

  // adder  
  adder_16bit find_sum (.r1(A), .r2(B), .ci(Cin), .carry(Cout_add), .result(add));
  
  //Overflow calc for addition
  wire MSB_mid;
  wire MSB_res_mid;
  xor(MSB_mid, A[15], B[15]);
  not(MSB_mid, MSB_mid);
  xor(MSB_res_mid, A[15], add[15]);
  and(Cout_add, MSB_mid, MSB_res_mid);
  

  // invert (-A = ~A + 1)
  // First - invert (~A)
  wire [15:0] notA; // ~A
  wire neg_carry; // carryout for invert (doubt needed, but just incase)
  //genvar i;
  generate
    for(i = 0; i<16; i=i+1) begin: negate_loop
        not(notA[i],A[i]);
    end
  endgenerate
  
  // Second - add 1 (~A + 1)
  adder_16bit neg_add (.r1(notA), .r2(16'b0), .ci(1'b1), .carry(Cout_sub), .result(invert));
  
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
    //SUB RESULT WAS FOUND HERE


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
    adder_16bit decrement (.r1(A), .r2(16'b1111_1111_1111_1111), .ci(1'b0), .carry(Cout_dec), .result(dec));
    
  //INCREMENT
  adder_16bit increment (.r1(A), .r2(16'b1), .ci(1'b0), .carry(Cout_inc), .result(inc));
  
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
  
  
  assign Cout_add_ar = {16{Cout_add}};
  assign Cout_sub_ar = {16{V}};
  assign Cout_dec_ar = {16{Cout_dec}};
  assign Cout_inc_ar = {16{Cout_inc}};
  assign Cout_asl_ar = {16{Cout_asl}};
  m161 mux_cout (
    .D({16'b0, 16'b0, Cout_asl_ar, 16'b0, 16'b0, 16'b0, 16'b0, 16'b0, 16'b0, Cout_inc_ar, Cout_dec_ar, 16'b0, 16'b0, Cout_add_ar, Cout_sub_ar}),//Order is important
    .S(S),
    .Y(Cout_Final_arr)
  );
  
  or(Cout, Cout_Final_arr[15], 1'b0);// Cout = Cout_Final_arr[15]
 wire [15:0] nY;
 genvar k;
 generate
    for(k=0; k<16;k = k+1) begin
        not(nY[k], Y[k]);
    end
endgenerate//nY = ALL 1's

 wire [15:0] zero_help;
  
  or (zero_help[0], nY[0], 1'b0);   // seed: zero_help[0] = nY[0]
  generate
    for (z = 1; z < 16; z = z + 1) begin : Set_ZBit
      and (zero_help[z], zero_help[z-1], nY[z]); // Ripple carry the result of the AND
    end
  endgenerate
  
  or(zero_Out, zero_help[15], 0);
  
  //not (zero_sub, or_acc[15]);     // zero_sub = 1 iff sub == 0
  //or(zero, zero_sub, 0);
 
  
endmodule
