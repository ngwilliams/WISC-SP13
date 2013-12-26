module mux4_1 (InA, InB, InC, InD, S, Out);

input InA;
input InB;
input InC;
input InD;
input [1:0] S;
output Out;
wire int1, int2;

mux2_1 MUX1 (InA, InB, S[0], int1);
mux2_1 MUX2 (InC, InD, S[0], int2);
mux2_1 MUX3 (int1, int2, S[1], Out);

endmodule
