module and_64(a,b,ans);
    input  signed [63:0]a;
    input  signed [63:0]b;
    output signed  [63:0] ans;

    genvar i;
    for(i= 0;i<64; i=i+1)begin
        and(ans[i] , a[i], b[i]);
    end
    endmodule
