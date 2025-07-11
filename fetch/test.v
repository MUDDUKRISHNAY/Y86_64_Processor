`include "fetch.v"

module fetch_tb;

  // Outputs from fetch
  wire [3:0] icode, ifun, rA, rB;
  wire [63:0] valC, valP;
  wire mem_error, instr_err;

  // Inputs to fetch
  reg clk;
  reg [63:0] PC;
  reg [0:79] instr;

  // Instruction memory
  reg [7:0] instr_mem[0:1023];

  // DUT
  fetch fetch_step(
    icode, ifun, rA, rB, valC, valP,
    mem_error, instr_err, clk, PC, instr
  );

  initial begin
    clk = 1;
    PC = 64'd0;

    // OPq: addq %r2, %r3
    instr_mem[0] = 8'b01100000; // icode=6, ifun=0
    instr_mem[1] = 8'b00100011; // rA=2, rB=3

    // irmovq: $123 -> %r1
    instr_mem[2] = 8'b00110000; // icode=3, ifun=0
    instr_mem[3] = 8'b11100001; // rA=F (unused), rB=1
    instr_mem[4] = 8'd123;      // valC (only low byte for simplicity)
    instr_mem[5] = 8'd0; instr_mem[6] = 8'd0;
    instr_mem[7] = 8'd0; instr_mem[8] = 8'd0;
    instr_mem[9] = 8'd0; instr_mem[10] = 8'd0;
    instr_mem[11] = 8'd0;

    // rmmovq: %r1 -> -4(%r2)
    instr_mem[12] = 8'b01000000; // icode=4, ifun=0
    instr_mem[13] = 8'b00010010; // rA=1, rB=2
    instr_mem[14] = 8'b11111100; // valC = -4 (low byte)
    instr_mem[15] = 8'd0; instr_mem[16] = 8'd0;
    instr_mem[17] = 8'd0; instr_mem[18] = 8'd0;
    instr_mem[19] = 8'd0; instr_mem[20] = 8'd0;
    instr_mem[21] = 8'd0;

    // mrmovq: -4(%r2) -> %r1
    instr_mem[22] = 8'b01010000; // icode=5, ifun=0
    instr_mem[23] = 8'b00010010; // rA=1, rB=2
    instr_mem[24] = 8'b11111100; // valC = -4 (low byte)
    instr_mem[25] = 8'd0; instr_mem[26] = 8'd0;
    instr_mem[27] = 8'd0; instr_mem[28] = 8'd0;
    instr_mem[29] = 8'd0; instr_mem[30] = 8'd0;
    instr_mem[31] = 8'd0;

    // call: address 100
    instr_mem[32] = 8'b10000000; // icode=8, ifun=0
    instr_mem[33] = 8'd100;      // valC = 100 (low byte only)
    instr_mem[34] = 8'd0; instr_mem[35] = 8'd0;
    instr_mem[36] = 8'd0; instr_mem[37] = 8'd0;
    instr_mem[38] = 8'd0; instr_mem[39] = 8'd0;
    instr_mem[40] = 8'd0;

    // ret
    instr_mem[41] = 8'b10010000;

    // halt
    instr_mem[42] = 8'b00000000;
  end

  // Instruction fetch based on PC
  always @(PC) begin
    instr = {
      instr_mem[PC],
      instr_mem[PC+1],
      instr_mem[PC+2],
      instr_mem[PC+3],
      instr_mem[PC+4],
      instr_mem[PC+5],
      instr_mem[PC+6],
      instr_mem[PC+7],
      instr_mem[PC+8],
      instr_mem[PC+9]
    };
  end

  // Clock toggling
  always #10 clk = ~clk;

  // PC updates after each instruction fetch
  always @(posedge clk)
    PC <= valP;

  // End simulation on halt
  always @(icode) begin
    if (icode == 4'b0000)
      $finish;
  end

  // Report memory or instruction errors
  always @(mem_error or instr_err) begin
    if (mem_error || instr_err)
      $display("Memory or Instruction Error at PC=%d", PC);
  end

  initial begin
    $monitor("clk=%b PC=%d icode=%b ifun=%b rA=%b rB=%b valC=%d valP=%d",
             clk, PC, icode, ifun, rA, rB, valC, valP);
  end

endmodule
