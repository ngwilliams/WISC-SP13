module I_WriteBack(
	//Outputs
	WriteData_W,
	WriteRegOut,
	WriteRegEnOut,
	Halt_Out,
	//Inputs
	MemReadData_M,
	AluResult_M,
	MemToReg_M,
	WriteRegIn,
	WriteRegEnIn,
	Halt_W
);

input [15:0] 	MemReadData_M, AluResult_M;
input 	MemToReg_M, WriteRegEnIn, Halt_W;
input [2:0] WriteRegIn;

output[15:0] WriteData_W;
output[2:0] WriteRegOut;
output WriteRegEnOut, Halt_Out;

assign WriteRegOut = WriteRegIn;
assign WriteRegEnOut = WriteRegEnIn;
assign Halt_Out = Halt_W;

//use mux on MemtoReg_M to determine if ReadData of ALU gets written back
//0 - ALU result
//1 - ReadData

mux2_1 WBMux [15:0] (.InA(AluResult_M), .InB(MemReadData_M), .S(MemToReg_M), .Out(WriteData_W));

endmodule
