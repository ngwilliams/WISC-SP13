module I_Fetch(

	//Outputs
	err,
	PCInc_FDq,
	Inst_FDq,
	Inst_F_Validq,
	//Inputs
	NextPC_E,
	Stall_F,
	Branch,
	Jump,
	clk,
	rst,
	BranchNOPF,
	Stall_D,
	DataMemStall
	);

input [15:0] NextPC_E;
input Stall_F, Branch, Jump, clk, rst, BranchNOPF, Stall_D, DataMemStall;
output [15:0] PCInc_FDq, Inst_FDq;
output err, Inst_F_Validq;

wire [15:0] PC, PC_Dff, PC_MuxOut, PC_Temp, Inst_F,Inst_F_Temp,Inst_F_Temp2, PCInc_F, PCInc_FDd, Inst_FDd,Inst_FDd_temp,NextPC_E2,NextPC_E3,NextPC_E4,NextPC_E5,NextPC_E6,PC_Dff_temp;
wire Inst_F_Validd;
wire CacheHit,Done,InstMemStall,valid,cacheBranch,cacheBranch2,cacheBranch3,cacheBranch4,cacheBranch5,cacheBranch6,cacheBranch7, DataMemStall_q,specialSignal,specialSignal2,specialSignal3,specialSignal4,specialSignal5,specialSignal6;
assign Inst_F_Validd = 1'b1;
assign cacheBranch = (Branch & InstMemStall) | (Jump & InstMemStall);

fulladder16 Adder1( .A(PC), .B(16'd2), .SUM(PCInc_F));



mem_system InstrMemory (.DataOut(Inst_F), .Done(Done), .Stall(InstMemStall), .CacheHit(CacheHit), .err(err), .Addr(PC_Temp), .DataIn(16'b0), .Rd(1'b1), .Wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst),.valid(valid));

dff PC_reg [15:0] (.q(PC[15:0]), .d(PC_Dff[15:0]), .clk(clk), .rst(rst));

mux2_1 PCMux1 [15:0] (.InA(PCInc_FDd), .InB(NextPC_E), .S((Branch | Jump)), .Out(PC_MuxOut));

mux2_1 PCMux2 [15:0] (.InA(PC_MuxOut), .InB(PC), .S((Stall_F & ~Branch) | (InstMemStall & ~Branch & ~Jump) | (~startDffOut) | (~CacheHit & ~valid & ~Jump & ~Branch) | cacheBranch6), .Out(PC_Dff_temp));

mux2_1 PCMux4 [15:0] (.InA(PC_Dff_temp), .InB(NextPC_E6), .S(specialSignal6), .Out(PC_Dff));

 mux2_1 PCMux3 [15:0] (.InA(PC), .InB(16'b0), .S(cacheBranch | cacheBranch2 | cacheBranch3 |
cacheBranch4 | cacheBranch5 | cacheBranch6), .Out(PC_Temp));
//////////////////////ADDED VALS//////////////////////////////////////////////

mux2_1 Inst_F_Stall_Mux [15:0] (.InA(16'b0000100000000000), .InB(Inst_F), .S(StartDff2Out), .Out(Inst_F_Temp));

mux2_1 Inst_F_Stall_Mux2 [15:0] (.InA(16'b0000100000000000), .InB(Inst_F_Temp), .S(valid), .Out(Inst_F_Temp2));

mux4_1 FD_StallMux[15:0] (.InA(Inst_F_Temp2), .InB(Inst_FDq), .InC(16'b0000100000000000), .InD(Inst_FDq), .S({BranchNOPF,(Stall_D | InstMemStall)}), .Out(Inst_FDd_temp));

mux2_1 FD_StallMux3[15:0] (.InA(Inst_FDd_temp), .InB(16'b0000100000000000), .S((Branch | (InstMemStall & ~Stall_D)) | cacheBranch6), .Out(Inst_FDd));


mux2_1 FD_StallMux2[15:0] (.InA(PCInc_F), .InB(PCInc_FDq), .S((Stall_D | InstMemStall) | (~CacheHit & ~valid)), .Out(PCInc_FDd));

dff DataMemStall_dff (
	.q(DataMemStall_q),
	.d(DataMemStall),
	.clk(clk),
	.rst(rst));

dff Fetch_Decode_dff[32:0] (
	.q({PCInc_FDq, Inst_FDq,Inst_F_Validq}),
	.d({PCInc_FDd, Inst_FDd,Inst_F_Validd}),
	.clk(clk),
	.rst(rst));

dff start_dff (
	.q(startDffOut),
	.d(1'b1),
	.clk(clk),
	.rst(rst));

dff start_dff2 (
	.q(StartDff2Out),
	.d(startDffOut),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff0 (
	.q(cacheBranch2),
	.d(cacheBranch),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff1 (
	.q(cacheBranch3),
	.d(cacheBranch2),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff2 (
	.q(cacheBranch4),
	.d(cacheBranch3),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff3 (
	.q(cacheBranch5),
	.d(cacheBranch4),
	.clk(clk),
	.rst(rst));
dff branch_stall_dff4 (
	.q(cacheBranch6),
	.d(cacheBranch5),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff5 (
	.q(cacheBranch7),
	.d(cacheBranch6),
	.clk(clk),
	.rst(rst));
////////////////////////////////////////////////////////////////
assign specialSignal = DataMemStall_q & Jump & cacheBranch6 & cacheBranch5 & cacheBranch4 & cacheBranch3 & cacheBranch2 & ~cacheBranch & Done & ~DataMemStall & ~CacheHit;

dff branch_stall2_dff1 [16:0] (
	.q({specialSignal2,NextPC_E2}),
	.d({specialSignal,NextPC_E}),
	.clk(clk),
	.rst(rst));

dff branch_stall2_dff2 [16:0] (
	.q({specialSignal3,NextPC_E3}),
	.d({specialSignal2,NextPC_E2}),
	.clk(clk),
	.rst(rst));

dff branch_stall2_dff3 [16:0] (
	.q({specialSignal4,NextPC_E4}),
	.d({specialSignal3,NextPC_E3}),
	.clk(clk),
	.rst(rst));
dff branch_stall2_dff4 [16:0] (
	.q({specialSignal5,NextPC_E5}),
	.d({specialSignal4,NextPC_E4}),
	.clk(clk),
	.rst(rst));

dff branch_stall2_dff5 [16:0] (
	.q({specialSignal6,NextPC_E6}),
	.d({specialSignal5,NextPC_E5}),
	.clk(clk),
	.rst(rst));

//////////////////////////////////////////////////
/*
module I_Fetch(

	//Outputs
	err,
	PCInc_FDq,
	Inst_FDq,
	Inst_F_Validq,
	//Inputs
	NextPC_E,
	Stall_F,
	Branch,
	Jump,
	clk,
	rst,
	BranchNOPF,
	Stall_D,
	DataMemStall
	);

input [15:0] NextPC_E;
input Stall_F, Branch, Jump, clk, rst, BranchNOPF, Stall_D, DataMemStall;
output [15:0] PCInc_FDq, Inst_FDq;
output err, Inst_F_Validq;

wire [15:0] PC, PC_Dff, PC_MuxOut, PC_Temp, Inst_F,Inst_F_Temp,Inst_F_Temp2, PCInc_F, PCInc_FDd, Inst_FDd,Inst_FDd_temp;
wire Inst_F_Validd;
wire CacheHit,Done,InstMemStall,valid,cacheBranch,cacheBranch2,cacheBranch3,cacheBranch4,cacheBranch5,cacheBranch6,cacheBranch7, DataMemStall_q;
assign Inst_F_Validd = 1'b1;
assign cacheBranch = (Branch & InstMemStall) | (Jump & InstMemStall);

fulladder16 Adder1( .A(PC), .B(16'd2), .SUM(PCInc_F));



mem_system InstrMemory (.DataOut(Inst_F), .Done(Done), .Stall(InstMemStall), .CacheHit(CacheHit), .err(err), .Addr(PC_Temp), .DataIn(16'b0), .Rd(1'b1), .Wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst),.valid(valid));

dff PC_reg [15:0] (.q(PC[15:0]), .d(PC_Dff[15:0]), .clk(clk), .rst(rst));

mux2_1 PCMux1 [15:0] (.InA(PCInc_FDd), .InB(NextPC_E), .S((Branch | Jump)), .Out(PC_MuxOut));

mux2_1 PCMux2 [15:0] (.InA(PC_MuxOut), .InB(PC), .S((Stall_F & ~Branch) | (InstMemStall & ~Branch & ~Jump) | (~startDffOut) | (~CacheHit & ~valid & ~Jump & ~Branch) | cacheBranch6), .Out(PC_Dff));


 mux2_1 PCMux3 [15:0] (.InA(PC), .InB(16'b0), .S(cacheBranch | cacheBranch2 | cacheBranch3 |
cacheBranch4 | cacheBranch5 | cacheBranch6), .Out(PC_Temp));
//////////////////////ADDED VALS//////////////////////////////////////////////

mux2_1 Inst_F_Stall_Mux [15:0] (.InA(16'b0000100000000000), .InB(Inst_F), .S(StartDff2Out), .Out(Inst_F_Temp));

mux2_1 Inst_F_Stall_Mux2 [15:0] (.InA(16'b0000100000000000), .InB(Inst_F_Temp), .S(valid), .Out(Inst_F_Temp2));

mux4_1 FD_StallMux[15:0] (.InA(Inst_F_Temp2), .InB(Inst_FDq), .InC(16'b0000100000000000), .InD(Inst_FDq), .S({BranchNOPF,(Stall_D | InstMemStall)}), .Out(Inst_FDd_temp));

mux2_1 FD_StallMux3[15:0] (.InA(Inst_FDd_temp), .InB(16'b0000100000000000), .S((Branch | (InstMemStall & ~Stall_D)) | cacheBranch6), .Out(Inst_FDd));


mux2_1 FD_StallMux2[15:0] (.InA(PCInc_F), .InB(PCInc_FDq), .S((Stall_D | InstMemStall) | (~CacheHit & ~valid)), .Out(PCInc_FDd));

dff DataMemStall_dff (
	.q(DataMemStall_q),
	.d(DataMemStall),
	.clk(clk),
	.rst(rst));

dff Fetch_Decode_dff[32:0] (
	.q({PCInc_FDq, Inst_FDq,Inst_F_Validq}),
	.d({PCInc_FDd, Inst_FDd,Inst_F_Validd}),
	.clk(clk),
	.rst(rst));

dff start_dff (
	.q(startDffOut),
	.d(1'b1),
	.clk(clk),
	.rst(rst));

dff start_dff2 (
	.q(StartDff2Out),
	.d(startDffOut),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff0 (
	.q(cacheBranch2),
	.d(cacheBranch),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff1 (
	.q(cacheBranch3),
	.d(cacheBranch2),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff2 (
	.q(cacheBranch4),
	.d(cacheBranch3),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff3 (
	.q(cacheBranch5),
	.d(cacheBranch4),
	.clk(clk),
	.rst(rst));
dff branch_stall_dff4 (
	.q(cacheBranch6),
	.d(cacheBranch5),
	.clk(clk),
	.rst(rst));

dff branch_stall_dff5 (
	.q(cacheBranch7),
	.d(cacheBranch6),
	.clk(clk),
	.rst(rst));
*/

endmodule
