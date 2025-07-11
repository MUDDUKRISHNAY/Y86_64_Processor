`timescale 1ns / 1ps
`include "decoder.v"

module decoder_tb;
  reg clk;
  reg [3:0] rA, rB, icode;
  reg [63:0] reg_file [0:14];

  wire [63:0] valA, valB;

  decoder decoderi(
    clk, rA, rB, icode,
    reg_file[0], reg_file[1], reg_file[2], reg_file[3], reg_file[4],
    reg_file[5], reg_file[6], reg_file[7], reg_file[8], reg_file[9],
    reg_file[10], reg_file[11], reg_file[12], reg_file[13], reg_file[14],
    valA, valB
  );

  initial begin
    clk = 1'b1;
    rA = 4'd3;
    rB = 4'd9;

    reg_file[0] = 64'd0;
    reg_file[1] = 64'd1;
    reg_file[2] = 64'd2;
    reg_file[3] = 64'd3;
    reg_file[4] = 64'd4;
    reg_file[5] = 64'd5;
    reg_file[6] = 64'd6;
    reg_file[7] = 64'd7;
    reg_file[8] = 64'd8;
    reg_file[9] = 64'd9;
    reg_file[10] = 64'd10;
    reg_file[11] = 64'd11;
    reg_file[12] = 64'd12;
    reg_file[13] = 64'd13;
    reg_file[14] = 64'd14;

    // Test each icode 
    icode = 4'b0000; #20;
    icode = 4'b0001; #20;
    icode = 4'b0010; #20;
    icode = 4'b0011; #20;
    icode = 4'b0100; #20;
    icode = 4'b0101; #20;
    icode = 4'b0110; #20;
    icode = 4'b0111; #20;
    icode = 4'b1000; #20;
    icode = 4'b1001; #20;
    icode = 4'b1010; #20;
    icode = 4'b1011; #20;

    $finish;
  end

  always #10 clk = ~clk;

  always @(clk) begin
    $display($time, "\nclk:%d icode:%d rA:%d rB:%d \nvalA:%d valB:%d", clk, icode, rA, rB, valA, valB);
  end

endmodule
