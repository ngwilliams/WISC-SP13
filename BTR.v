module BTR(
	//Inputs
	A,
	//outputs
	B
	);

input [15:0] A;
output [15:0] B;

assign B = {A[0],A[1],A[2],A[3],A[4],A[5],A[6],A[7],A[8],A[9],A[10],A[11],A[12],A[13],A[14],A[15]};


endmodule