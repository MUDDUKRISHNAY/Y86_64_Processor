`timescale 1ns / 1ps

module memory(
  clk,icode,valA,valE,valP,valM
);

  input clk;
  
  input [3:0] icode;
  input [63:0] valA;
  input [63:0] valE; 
  input [63:0] valP;
  
  output reg [63:0] valM;
  output reg [63:0] datamem;

  reg [7:0] data_mem[0:1023];
  
  always@(*)
  begin
    data_mem[valA] = 8'd200; 
    data_mem[valE] = 8'd100;
    case (icode)
    4'b0100,4'b1010:data_mem[valE]=valA; 
    4'b0101:valM=data_mem[valE];  
    4'b1011:valM=data_mem[valA];
    4'b1000:data_mem[valE]=valP; 
    4'b1001: valM=data_mem[valA]; 
    endcase


  end
  
  always@(data_mem[valE])
    $display("mem_allocated->%b",data_mem[valE]);
endmodule
