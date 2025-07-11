module fulladder_sub(a,b,c,sum,carry);

input a;
input b;
input c;
output sum;
output carry;

wire w1,w2,w3;

///carry = (a&b)|(b&c)|(c&a);
//sum = a^b^c;

xor a_xor_b(w1,a,b);
xor sum1(sum,w1,c);
and a_and_b(w2,a,b);
and xyz(w3,w2,c);
or carry1(carry,w2,w3);

endmodule


