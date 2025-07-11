`timescale 1ns/10ps
`include "XOR.v"

module xor_tb;

    reg signed [63:0] a;
    reg signed [63:0] b;
    wire [63:0] ans;

    xor_64 xori(a, b, ans);

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, xor_tb);

       

        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'hFFFFFFFFFFFFFFFF;
        #10;

        a = 64'hFFFFFFFFFFFFFFFE;
        b = 64'hFFFFFFFFFFFFFFFF;
        #10;

        a = 64'hFFFFFFFFFFFFFFFD;
        b = 64'hFFFFFFFFFFFFFFFE;
        #10;

        a = 64'hFFFFFFFFFFFFFFFC;
        b = 64'hFFFFFFFFFFFFFFFD;
        #10;

        a = 64'hFFFFFFFFFFFFFFFB;
        b = 64'hFFFFFFFFFFFFFFFC;
        #10;

        a = 64'hFFFFFFFFFFFFFFFA;
        b = 64'hFFFFFFFFFFFFFFFB;
        #10;

        a = 64'hFFFFFFFFFFFFFFF9;
        b = 64'hFFFFFFFFFFFFFFFA;
        #10;

        a = 64'hFFFFFFFFFFFFFFF8;
        b = 64'hFFFFFFFFFFFFFFF9;
        #10;

        a = 64'hFFFFFFFFFFFFFFF7;
        b = 64'hFFFFFFFFFFFFFFF8;
        #10;

        a = 64'hFFFFFFFFFFFFFFF6;
        b = 64'hFFFFFFFFFFFFFFF7;
        #10;
    end

endmodule
