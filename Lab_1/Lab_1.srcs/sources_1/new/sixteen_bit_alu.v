module sixteen_bit_alu(
  input        clock,          // unused in combinational version
  input  [15:0] A,
  input  [15:0] B,
  input         Cin,
  input  [3:0]  S,
  output        Cout,
  output [15:0] Y
);
  wire [15:0] sub, add, bit_or, bit_and, dec, inc, invert, asl, asr, lsl, lsr;

  assign add     = A + B + Cin;
  assign sub     = A - B - Cin;
  assign bit_or  = A | B;
  assign bit_and = A & B;
  assign inc     = A + 16'd1;
  assign dec     = A - 16'd1;
  assign invert  = ~A;
  
  
  //assign lsl     = A(b'1,[14:0]);
  assign lsr     = A >> 1;

  wire signed [15:0] As = A;
  assign asl = As <<< 1;
  assign asr = As >>> 1;

  wire [16:0] add_ext = {1'b0, A} + {1'b0, B} + Cin;
  assign Cout = (S == 4'dX /*  ADD code */) ? add_ext[16] : 1'b0;

  // Flattened-bus 16:1 mux
  m161 #(.W(16), .N(11)) mux_alu (
    .D({sub, add, bit_or, bit_and, dec, inc, invert, asl, asr, lsl, lsr}),//Order is important
    .S(S),
    .Y(Y)
  );
endmodule
