module I_Memory(
	//Outputs
	MemReadData_M,
	AluResult_M,
	MemToReg_M,
	WriteRegOut,
	WriteRegEnOut,
	Halt_W,
	Rd_M,
	RdV_M,
	MemRead_M,
	Rs_WB,
	RsV_WB,
	MemWrite_M,
	err,
	DataMemStall,
	//Inputs
	AluResult_E,
	ReadData2_E,
	MemWrite_E,
	MemRead_E,
	MemToReg_E,
	Halt_E,
	WriteRegIn,
	WriteRegEnIn,
	Halt_WIn,
	Rs_M,
	RsV_M,
	Rd_EM,
	RdV_EM,
	clk,
	rst
);

input [15:0] AluResult_E,ReadData2_E;
input 	MemWrite_E,MemRead_E,MemToReg_E, Halt_E, WriteRegEnIn, Halt_WIn, clk, rst, RsV_M, RdV_EM;
input [2:0] WriteRegIn, Rs_M, Rd_EM;

output[15:0] MemReadData_M,AluResult_M;
output MemToReg_M, WriteRegEnOut, Halt_W, err,RdV_M,RsV_WB,MemRead_M,MemWrite_M,DataMemStall;
output [2:0] WriteRegOut, Rd_M,Rs_WB;

wire [15:0] MemReadData_M_Temp, MemReadData_M_Temp_dffd, MemReadData_M_Temp_dffq,MemReadData_M_Temp2;
wire [15:0]MemReadData_M_Tempd, AluResult_Ed;
wire [2:0] WriteRegInd,Rd_EMd,Rs_Md;
wire MemToReg_Ed,WriteRegEnInd,Halt_Ed,RdV_EMd,MemRead_Ed,MemWrite_Ed,RsV_Md,valid;
wire Done,CacheHit;

wire [15:0] AluResult_E_hold,ReadData2_E_hold,AluResult_E_mem,ReadData2_E_mem,AluResult_E_loop,ReadData2_E_loop;
wire MemWrite_E_hold,MemRead_E_hold, Halt_E_hold, Halt_WIn_hold,MemWrite_E_mem,MemRead_E_mem, Halt_E_mem, Halt_WIn_mem,MemWrite_E_loop,MemRead_E_loop, Halt_E_loop, Halt_WIn_loop;






mux2_1 DataMemInMux2[35:0] (.InA({AluResult_E,ReadData2_E,MemWrite_E,MemRead_E, Halt_E, Halt_WIn}), .InB({AluResult_E_hold,ReadData2_E_hold,MemWrite_E_hold,MemRead_E_hold, Halt_E_hold, Halt_WIn_hold}),.S(DataMemStall), .Out({AluResult_E_loop,ReadData2_E_loop,MemWrite_E_loop,MemRead_E_loop, Halt_E_loop, Halt_WIn_loop}));

dff Hold_stall_dff[35:0] (
	.q({AluResult_E_hold,ReadData2_E_hold,MemWrite_E_hold,MemRead_E_hold, Halt_E_hold, Halt_WIn_hold}),
	.d({AluResult_E_loop,ReadData2_E_loop,MemWrite_E_loop,MemRead_E_loop, Halt_E_loop, Halt_WIn_loop}),
	.clk(clk),
	.rst(rst));

mux2_1 DataMemInMux[35:0] (.InA({AluResult_E,ReadData2_E,MemWrite_E,MemRead_E, Halt_E, Halt_WIn}), .InB({AluResult_E_hold,ReadData2_E_hold,MemWrite_E_hold,MemRead_E_hold, Halt_E_hold, Halt_WIn_hold}),.S(DataMemStall), .Out({AluResult_E_mem,ReadData2_E_mem,MemWrite_E_mem,MemRead_E_mem, Halt_E_mem, Halt_WIn_mem}));

mem_system DataMemory (.DataOut(MemReadData_M_Temp), .Done(Done), .Stall(DataMemStall), .CacheHit(CacheHit), .err(err), .Addr(AluResult_E_mem), .DataIn(ReadData2_E_mem), .Rd(MemRead_E_mem), .Wr(MemWrite_E_mem & ~Halt_E_mem), .createdump(Halt_WIn_mem), .clk(clk), .rst(rst), .valid(valid));


dff Memory_Write_dff[48:0] (
	.q({MemReadData_M, AluResult_M, MemToReg_M, WriteRegOut, WriteRegEnOut, Halt_W,Rd_M,RdV_M,MemToReg_M,MemRead_M,MemWrite_M,Rs_WB,RsV_WB}),
	.d({MemReadData_M_Tempd, AluResult_Ed, MemToReg_Ed, WriteRegInd, WriteRegEnInd, Halt_Ed,Rd_EMd,RdV_EMd,MemToReg_Ed,MemRead_Ed,MemWrite_Ed,Rs_Md,RsV_Md}),
	.clk(clk),
	.rst(rst));

mux2_1 DataMemStallMux[48:0] (.InA({MemReadData_M_Temp, AluResult_E, MemToReg_E, WriteRegIn, WriteRegEnIn, Halt_E,Rd_EM,RdV_EM,MemToReg_E,MemRead_E,MemWrite_E,Rs_M,RsV_M}), .InB({MemReadData_M, AluResult_M, MemToReg_M, WriteRegOut, WriteRegEnOut, Halt_W,Rd_M,RdV_M,MemToReg_M,MemRead_M,MemWrite_M,Rs_WB,RsV_WB}),.S(DataMemStall), .Out({MemReadData_M_Temp2, AluResult_Ed, MemToReg_Ed, WriteRegInd, WriteRegEnInd, Halt_Ed,Rd_EMd,RdV_EMd,MemToReg_Ed,MemRead_Ed,MemWrite_Ed,Rs_Md,RsV_Md}));

mux2_1 done_value_Mux[15:0] (.InA(MemReadData_M_Temp2), .InB(MemReadData_M_Temp),.S(DataMemStall&valid), .Out(MemReadData_M_Tempd));


/*mux2_1 DataMemInMux2[35:0] (.InA({AluResult_E,ReadData2_E,MemWrite_E,MemRead_E, Halt_E, Halt_WIn}), .InB({AluResult_E_hold,ReadData2_E_hold,MemWrite_E_hold,MemRead_E_hold, Halt_E_hold, Halt_WIn_hold}),.S(DataMemStall), .Out({AluResult_E_loop,ReadData2_E_loop,MemWrite_E_loop,MemRead_E_loop, Halt_E_loop, Halt_WIn_loop}));

dff Hold_stall_dff[35:0] (
	.q({AluResult_E_hold,ReadData2_E_hold,MemWrite_E_hold,MemRead_E_hold, Halt_E_hold, Halt_WIn_hold}),
	.d({AluResult_E_loop,ReadData2_E_loop,MemWrite_E_loop,MemRead_E_loop, Halt_E_loop, Halt_WIn_loop}),
	.clk(clk),
	.rst(rst));

mux2_1 DataMemInMux[35:0] (.InA({AluResult_E,ReadData2_E,MemWrite_E,MemRead_E, Halt_E, Halt_WIn}), .InB({AluResult_E_hold,ReadData2_E_hold,MemWrite_E_hold,MemRead_E_hold, Halt_E_hold, Halt_WIn_hold}),.S(DataMemStall), .Out({AluResult_E_mem,ReadData2_E_mem,MemWrite_E_mem,MemRead_E_mem, Halt_E_mem, Halt_WIn_mem}));

mem_system DataMemory (.DataOut(MemReadData_M_Temp), .Done(Done), .Stall(DataMemStall), .CacheHit(CacheHit), .err(err), .Addr(AluResult_E_mem), .DataIn(ReadData2_E_mem), .Rd(MemRead_E_mem), .Wr(MemWrite_E_mem & ~Halt_E_mem), .createdump(Halt_WIn_mem), .clk(clk), .rst(rst), .valid(valid));


dff Memory_Write_dff[48:0] (
	.q({MemReadData_M, AluResult_M, MemToReg_M, WriteRegOut, WriteRegEnOut, Halt_W,Rd_M,RdV_M,MemToReg_M,MemRead_M,MemWrite_M,Rs_WB,RsV_WB}),
	.d({MemReadData_M_Tempd, AluResult_Ed, MemToReg_Ed, WriteRegInd, WriteRegEnInd, Halt_Ed,Rd_EMd,RdV_EMd,MemToReg_Ed,MemRead_Ed,MemWrite_Ed,Rs_Md,RsV_Md}),
	.clk(clk),
	.rst(rst));

mux2_1 done_value_Mux[15:0] (.InA(MemReadData_M_Temp), .InB(MemReadData_M_Temp_dffq),.S(valid), .Out(MemReadData_M_Temp_dffd));

dff done_value_dff[15:0] (
	.q(MemReadData_M_Temp_dffq),
	.d(MemReadData_M_Temp_dffd),
	.clk(clk),
	.rst(rst));

mux2_1 DataMemStallMux[48:0] (.InA({MemReadData_M_Temp_dffd, AluResult_E, MemToReg_E, WriteRegIn, WriteRegEnIn, Halt_E,Rd_EM,RdV_EM,MemToReg_E,MemRead_E,MemWrite_E,Rs_M,RsV_M}), .InB({MemReadData_M, AluResult_M, MemToReg_M, WriteRegOut, WriteRegEnOut, Halt_W,Rd_M,RdV_M,MemToReg_M,MemRead_M,MemWrite_M,Rs_WB,RsV_WB}),.S(DataMemStall), .Out({MemReadData_M_Tempd, AluResult_Ed, MemToReg_Ed, WriteRegInd, WriteRegEnInd, Halt_Ed,Rd_EMd,RdV_EMd,MemToReg_Ed,MemRead_Ed,MemWrite_Ed,Rs_Md,RsV_Md}));

*/


endmodule
