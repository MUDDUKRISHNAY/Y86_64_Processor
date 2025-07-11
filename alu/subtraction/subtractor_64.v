`include "alu/subtraction/fulladder_sub.v"

module subtractor_64 (
    input  signed [63:0] a,
    input  signed [63:0] b,
    output signed [63:0] difference,
    output overflow,
    output borrow
);

    wire signed [63:0] b_temp;
    wire [64:0] c0;

    assign c0[0] = 1'b1;          
    assign b_temp = ~b;           
    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin 
            fulladder_sub fa (
                .a(a[i]),
                .b(b_temp[i]),
                .c(c0[i]),
                .sum(difference[i]),
                .carry(c0[i+1])
            );
        end
    endgenerate

    assign borrow = c0[64];
    assign overflow = c0[64] ^ c0[63];  

endmodule
