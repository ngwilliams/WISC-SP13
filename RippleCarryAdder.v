module fulladder4( A, B, C, SUM, CO);
input [3:0] A, B;
input C;
output [3:0] SUM;
output CO;
wire int1, int2, int3;

adder ADD1(A[0], B[0], C, SUM[0], int1);
adder ADD2(A[1], B[1], int1, SUM[1], int2);
adder ADD3(A[2], B[2], int2, SUM[2], int3);
adder ADD4(A[3], B[3], int3, SUM[3], CO);

endmodule
