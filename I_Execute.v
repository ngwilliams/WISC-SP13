module I_Execute(
	//Outputs
	NextPC_E,
	AluResult_EMq,
	AluInput2ForwardMuxOutq,
	MemWrite_EMq,
	MemRead_EMq,
	MemToReg_EMq,
	Halt_EMq,
	WriteReg_EMq,
	WriteRegEn_EMq,
	Rd_EMq,
	RdV_EMq,
	err,
	BranchEF,
	Rs_M,
	RsV_M,
	//Inputs
	Rs_E,
	RsV_E,
	JumpReg_D,
	JumpImm_D,
	PCInc_D,
	ReadData1_D,
	ReadData2_D,
	Imm16_D,
	AluSrc_D,
	AluSrc2_D, 
	AluSrc3_D,
	AluControl_D,
	JumpR_D,
	Jump_D,
	Branch_D,
	MemWrite_D,
	MemRead_D,
	MemToReg_D,
	Halt_D,
	WriteRegIn,
	WriteRegEnIn,
	RdIn,
	RdVIn,
	AluResultM,
	AluResultWB,
	clk,
	rst,
	Inst_D,
	WriteData_W,//forwarded data from WB
	ALUResult_E,//forwarded data from EX
	Rt_E,
	WriteReg_MW,
	Rd_MW,
	Rs_MW,
	RsV_MW,
	DataMemStall,
	RtV_E,
	RdV_M,
	RdV_WB
);

input [15:0] Inst_D, JumpReg_D,JumpImm_D,PCInc_D,ReadData2_D, Imm16_D, ReadData1_D,AluResultWB,AluResultM, WriteData_W, ALUResult_E;
input [13:0] AluControl_D;
input [2:0] WriteRegIn, RdIn, Rs_E, Rt_E, Rd_MW, Rs_MW;
input JumpR_D,Jump_D,Branch_D,MemWrite_D,MemRead_D,MemToReg_D,Halt_D, WriteRegEnIn, RdVIn, clk, rst, AluSrc_D,AluSrc2_D, AluSrc3_D, RsV_E, WriteReg_MW, RsV_MW,DataMemStall,RtV_E,RdV_M,RdV_WB;

output[15:0] NextPC_E,AluResult_EMq,AluInput2ForwardMuxOutq;
output[2:0] WriteReg_EMq, Rd_EMq, Rs_M;
output MemWrite_EMq,MemRead_EMq,MemToReg_EMq, Halt_EMq, WriteRegEn_EMq, RdV_EMq, err, RsV_M;

output BranchEF;

wire Flag;
wire [1:0] ForwardA, ForwardB;
wire [15:0] PCBranch_D, AluResult_E, AluInput1ForwardMuxOut, AluInput2ForwardMuxOut;

wire [15:0] AluResult_E_temp, AluInput2ForwardMuxOut_temp;
wire MemWrite_E_temp, MemRead_E_temp, MemToReg_E_temp, Halt_E_temp, WriteRegEnIn_temp,RdVIn_temp,RsV_E_temp; 
wire [2:0] WriteRegIn_temp, RdIn_temp, Rs_E_temp;
//Signals that Pass through
assign MemWrite_E = MemWrite_D;
assign MemRead_E = MemRead_D;
assign MemToReg_E = MemToReg_D;
assign Halt_E = Halt_D;
assign WriteRegOut = WriteRegIn;
assign WriteRegEnOut = WriteRegEnIn;
assign RdOut = RdIn;
assign RdVOut = RdVIn;
assign err = 1'b0;
// Moved from Decode

wire [15:0] Source1toSource3, AluInput1, AluInput2,sign_extended11_16;

mux2_1 ALUSource[15:0] (.InA(AluInput2ForwardMuxOut), .InB(Imm16_D), .S(AluSrc_D), .Out(Source1toSource3));
mux2_1 ALUSource2[15:0] (.InA(AluInput1ForwardMuxOut), .InB(PCInc_D), .S(AluSrc2_D), .Out(AluInput1));
mux2_1 ALUSource3[15:0] (.InA(Source1toSource3), .InB(16'd0), .S(AluSrc3_D), .Out(AluInput2));

SignExtend11_16 sign_extender11_16(.in(Inst_D[10:0]), .out(sign_extended11_16)); 

fulladder16 Adder1( .A(sign_extended11_16), .B(PCInc_D), .SUM(JumpImm_D));

fulladder16 Adder2( .A(Imm16_D), .B(AluInput1ForwardMuxOut), .SUM(JumpReg_D));
fulladder16 Adder3( .A(PCInc_D), .B(Imm16_D), .SUM(PCBranch_D));

//Instantiate ALU
Alu ALU (.A(AluInput1), .B(AluInput2), .AluControl(AluControl_D), .Flag(Flag), .Out(AluResult_E));

assign BranchEF = Branch_D && Flag;

//Branch Mux
wire [15:0] BranchMuxOut;
mux2_1 BranchMux [15:0] (.InA(PCInc_D),.InB(PCBranch_D), .S(BranchEF), .Out(BranchMuxOut));

//Jump R Mux
wire [15:0] JumpMuxOut;
mux2_1 JumpRMux [15:0] (.InA(JumpImm_D), .InB(JumpReg_D), .S(JumpR_D), .Out(JumpMuxOut));

mux2_1 BranchOrJumpMux [15:0] (.InA(BranchMuxOut), .InB(JumpMuxOut), .S(Jump_D), .Out(NextPC_E));

DataForwardingUnit DFU (.RegWrite_EM(WriteRegEn_EMq), .Rd_EM(Rd_EMq), .Rs_DE(Rs_E), .Rt_DE(Rt_E), .RegWrite_MW(WriteReg_MW), .Rd_MW(Rd_MW), .forwardA(ForwardA), .forwardB(ForwardB), .Rs_EM(Rs_M), .RsV_EM(RsV_M), .Rs_MW(Rs_MW), .RsV_MW(RsV_MW), .ReadMem_EM(MemRead_E),.RsV_DE(RsV_E),.RdV_EM(RdV_M),.RtV_DE(RtV_E), .RdV_MW(RdV_WB));


mux4_1 ALUIn1ForwardMux [15:0] (.InA(ReadData1_D), .InB(WriteData_W), .InC(ALUResult_E), .InD(AluResultM), .S(ForwardA[1:0]), .Out(AluInput1ForwardMuxOut));
mux4_1 ALUIn2ForwardMux [15:0] (.InA(ReadData2_D), .InB(WriteData_W), .InC(ALUResult_E), .InD(16'dx), .S(ForwardB[1:0]), .Out(AluInput2ForwardMuxOut));

mux2_1 ExStallMux [47:0] (
	.InA({AluResult_E, AluInput2ForwardMuxOut, MemWrite_E, MemRead_E, MemToReg_E, Halt_E, WriteRegIn, WriteRegEnIn, RdIn, RdVIn, Rs_E, RsV_E}), 
	.InB({AluResult_EMq, AluInput2ForwardMuxOutq, MemWrite_EMq, MemRead_EMq, MemToReg_EMq, Halt_EMq, WriteReg_EMq, WriteRegEn_EMq, Rd_EMq, RdV_EMq,Rs_M,RsV_M}), 
	.S(DataMemStall), 
	.Out({AluResult_E_temp, AluInput2ForwardMuxOut_temp, MemWrite_E_temp, MemRead_E_temp, MemToReg_E_temp, Halt_E_temp, WriteRegIn_temp, WriteRegEnIn_temp, RdIn_temp, RdVIn_temp, Rs_E_temp, RsV_E_temp}));

dff Execute_Memory_dff[47:0] (
	.q({AluResult_EMq, AluInput2ForwardMuxOutq, MemWrite_EMq, MemRead_EMq, MemToReg_EMq, Halt_EMq, WriteReg_EMq, WriteRegEn_EMq, Rd_EMq, RdV_EMq,Rs_M,RsV_M}),
	.d({AluResult_E_temp, AluInput2ForwardMuxOut_temp, MemWrite_E_temp, MemRead_E_temp, MemToReg_E_temp, Halt_E_temp, WriteRegIn_temp, WriteRegEnIn_temp, RdIn_temp, RdVIn_temp, Rs_E_temp, RsV_E_temp}),
	.clk(clk),
	.rst(rst));

endmodule
