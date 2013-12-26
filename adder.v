module adder(A, B, Cin, S, Cout);
input A, B, Cin;
output S, Cout;
wire int1, int2, int3, int4, int5, int6;

xor2 XOR1 (A, B, int1);
xor2 XOR2 (int1, Cin, S);
nand2 NAND1 (Cin, int1, int2);
nand2 NAND2 (A, B, int3);
nor2  NOR1  (int4, int5, int6);
not1 NOT1 (int2, int4);
not1 NOT2 (int3, int5);
not1 NOT3 (int6, Cout);

endmodule
