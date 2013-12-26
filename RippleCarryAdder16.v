module fulladder16( A, B, SUM);
input [15:0] A, B;
output [15:0] SUM;
wire int1, int2, int3, CO;

fulladder4 ADD1(A[3:0], B[3:0],1'b0, SUM[3:0], int1);
fulladder4 ADD2(A[7:4], B[7:4], int1, SUM[7:4], int2);
fulladder4 ADD3(A[11:8], B[11:8], int2, SUM[11:8], int3);
fulladder4 ADD4(A[15:12], B[15:12], int3, SUM[15:12], CO);

endmodule

