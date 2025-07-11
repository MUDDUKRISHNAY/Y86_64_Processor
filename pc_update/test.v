`timescale 1ns / 1ps
`include "pc.v"

module pcupdate_tb;

  // Inputs
  reg clk;
  reg [3:0] icode;
  reg cnd;
  reg [63:0] valC, valM, valP;

  // Output
  wire [63:0] pcnxt;

  // Instantiate DUT
  pc_update uut (
    .clk(clk),
    .icode(icode),
    .cnd(cnd),
    .valC(valC),
    .valM(valM),
    .valP(valP),
    .pcnxt(pcnxt)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    $display("Time   |clk icode cnd                valC                 valM                 valP  |                 pcnxt");
    $monitor("%4dns |  %b   %h    %b %d %d %d  | %d", 
              $time, clk, icode, cnd, valC, valM, valP, pcnxt);

    // Initialize
    clk = 0;
    icode = 4'b0000; // halt
    valC = 64'd100;
    valM = 64'd200;
    valP = 64'd300;
    cnd = 1;

    #10 icode = 4'b0111; cnd = 1; // jxx with cnd true
    #10 icode = 4'b0111; cnd = 0; // jxx with cnd false
    #10 icode = 4'b1000;          // call
    #10 icode = 4'b1001;          // ret
    #10 icode = 4'b0010;          // default (e.g., cmovxx)
    #10 $finish;
  end

endmodule
