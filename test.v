`timescale 1ns / 1ps
`include "alu.v"

module alu_tb;

  reg signed [63:0] a, b;
  reg [1:0] control;
  wire signed [63:0] ans;
  wire overflow;
  

  alu  alui(control, a, b, ans, overflow);

  initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, alu_tb);

   
    // ADD
    control = 2'b00;
    a = 64'h00000001; b = 64'h00000002; 
    #10;
    a = 64'h7FFFFFFFFFFFFFFF; b = 64'd1;
     #10;

    // SUB
    control = 2'b01;
    a = 64'h00000002; b = 64'h00000001; 
    #10;
    a = -64'd10; b = 64'd5; 
    #10;

    // AND
    control = 2'b10;
    a = 64'hFF00FF00FF00FF00; 
    b = 64'h0F0F0F0F0F0F0F0F; 
    #10;
    
    

    // XOR
    control = 2'b11;
    a = 64'hAAAAAAAAAAAAAAAA; 
    b = 64'h5555555555555555; 
    #10;

   
    $finish;
  end

  
endmodule
