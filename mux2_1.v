module mux2_1 (InA, InB, S, Out);
input InA;
input InB;
input S;
output Out;
wire int1, int2, int3;

nand2 NAND1 (InA,int1,int2);
nand2 NAND2 (S,InB,int3);
nand2 NAND3 (int2,int3,Out);
not1 notGate (S,int1);

endmodule
