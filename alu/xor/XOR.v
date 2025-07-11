module xor_64(a,b,ans);
    input [63:0]a;
    input [63:0]b;
    output [63:0]ans;

    genvar i;
    for(i= 0;i<64; i=i+1)begin
        xor(ans[i] , a[i], b[i]);
      end
endmodule
