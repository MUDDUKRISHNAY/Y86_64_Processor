`timescale 1ns / 1ps

`include "alu/addtion/adder_64.v"
`include "alu/subtraction/subtractor_64.v"
`include "alu/xor/XOR.v"
`include "alu/and/AND.v"

module alu(control, a, b, ans , overflow  );

  input signed [63:0] a;
  input signed [63:0] b;
  input [1:0] control;
  output signed [63:0] ans;
  output overflow;
  

  wire signed [63:0] ans_add;
  wire signed [63:0] ans_sub;
  wire signed [63:0] ans_and;
  wire signed [63:0] ans_xor;

  wire overflow_add, overflow_sub;
  wire carry_add, carry_sub;

  adder_64 add(a, b, ans_add, overflow_add, carry_add);  
  subtractor_64 sub(a, b, ans_sub, overflow_sub, carry_sub);
  and_64 anda(a, b, ans_and);
  xor_64 xora(a, b, ans_xor);

  reg signed [63:0] ansfinal;
  reg overflowfinal;

  always @(*) begin
    case (control)
      2'b00: begin
        ansfinal = ans_add;
        overflowfinal = overflow_add;
       
      end
      2'b01: begin
        ansfinal = ans_sub;
        overflowfinal = overflow_sub;
       
      end
      2'b10: begin
        ansfinal = ans_and;
        overflowfinal = 1'b0;
      end
      
      2'b11: begin
        ansfinal = ans_xor;
        overflowfinal = 1'b0;
      end
      
      default: begin
          ansfinal = 1'b0;
          overflowfinal = 1'b0;
          end
    endcase
  end

  assign ans = ansfinal;
  assign overflow = overflowfinal;

endmodule
