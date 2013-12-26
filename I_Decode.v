module I_Decode(

	//Outputs
	PCInc_DEq,
	ReadData1_DEq,
	ReadData2_DEq,
	ALUControl_DEq,
	JumpR_DEq,
	Jump_DEq,
	Branch_DEq,
	MemWrite_DEq,
	MemRead_DEq,
	MemToReg_DEq,
	Halt_DEq,
	WriteRegOutq,
	WriteRegEnOutq,
	Rs_D,
	Rt_D,
	Rs_DEq,
	Rt_DEq,
	Rd_E,
	RsV,
	RtV,
	RdV,
	RsV_DEq,
	RtV_DEq,
	err,
	Branch_DEd,
	Jump_DEd,
	AluSrc_DEq,
	AluSrc2_DEq,
	AluSrc3_DEq,
	Imm16_DEq,
	Inst_DEq,
	//Inputs
	clk,
	rst,
	PCInc_F,
	WriteData_W,
	Inst_F,
	WriteRegIn,
	WriteRegEnIn,
	Inst_F_Valid,
	Flush_E,
	DataMemStall
	);
input WriteRegEnIn, Inst_F_Valid, Flush_E, clk, rst,DataMemStall;
input[15:0] PCInc_F, WriteData_W, Inst_F;
input[2:0] WriteRegIn;
output[15:0]   PCInc_DEq,Imm16_DEq, ReadData2_DEq, ReadData1_DEq,Inst_DEq;
output[13:0] ALUControl_DEq;
output[2:0] WriteRegOutq, Rs_D, Rt_D, Rd_E, Rs_DEq, Rt_DEq;
output JumpR_DEq, Jump_DEq, Branch_DEq, MemWrite_DEq, MemRead_DEq, MemToReg_DEq, Halt_DEq, WriteRegEnOutq, RsV, RtV, RdV, err, Jump_DEd, Branch_DEd, AluSrc_DEq, AluSrc2_DEq, AluSrc3_DEq, RsV_DEq, RtV_DEq;

wire[15:0] ReadData1, ReadData2, Imm16_D, SLBIExtRes, PCInc_D, ReadData2_D, ReadData1_D,  PCInc_DEd, Imm16_DEd, ReadData2_DEd, ReadData1_DEd,Inst_DEd, PCInc_DEd1, Imm16_DEd1, ReadData2_DEd1, ReadData1_DEd1,Inst_DEd1;
wire[13:0] ALUControl_D, ALUControl_DEd, ALUControl_DEd1;
wire[2:0] WriteRegOut, Rd_D, WriteRegOutd, Rs_E_temp, Rt_E_temp, Rs_Ed,Rt_Ed, WriteRegOutd1,Rs_Ed1,Rt_Ed1,Rd_D_temp;
wire[3:0] ALUOp;
wire[1:0] RegDst, ImmSel, ALUSpecSel1, ALUSpecSel1Res, ALUSpecSel2Res;
wire AluSrc_D, AluSrc2_D, AluSrc3_D, SLBIExt, ALUSpecSel2, JumpR_D, Jump_D, Branch_D, MemWrite_D, MemRead_D,MemToReg_D, Halt_D, WriteRegEnOut, JumpR_DEd, MemWrite_DEd, MemRead_DEd, MemToReg_DEd, Halt_DEd,RdV_temp,WriteRegEnOutd,AluSrc_DEd, AluSrc2_DEd, AluSrc3_DEd,RsV_DEd,RtV_DEd,RdV_d, errReg, errALU, AluSrc_DEd1, AluSrc2_DEd1, AluSrc3_DEd1, JumpR_DEd1, Jump_DEd1, Branch_DEd1, MemWrite_DEd1, MemRead_DEd1, MemToReg_DEd1, Halt_DEd1, WriteRegEnOutd1, RdV_d1,RsV_DEd1,RtV_DEd1;

wire [4:0] opCode;
wire Inst_F_ValidW = Inst_F_Valid;


assign err = errReg | errALU;

mux2_1 opCodeMux [4:0] (.InA(5'b00001),.InB(Inst_F[15:11]),.S(Inst_F_ValidW),.Out(opCode)); //Used for Not getting HALT as first command in Pipe

control Control (.OpCode(opCode), .RegDst(RegDst), .MemRead(MemRead_D), .MemToReg(MemToReg_D), .AluOp(ALUOp), .MemWrite(MemWrite_D), .AluSrc(AluSrc_D), .AluSrc2(AluSrc2_D), .AluSrc3(AluSrc3_D), .RegWrite(WriteRegEnOut), .Jump(Jump_D), .Branch(Branch_D), .JumpR(JumpR_D), .Halt(Halt_D), .ImmSel(ImmSel[1:0]), .SLBIExt(SLBIExt), .AluSpecSel1(ALUSpecSel1), .AluSpecSel2(ALUSpecSel2));


mux4_1 RegDSTMux[2:0] (.InA(Inst_F[7:5]), .InB(Inst_F[10:8]), .InC(Inst_F[4:2]), .InD(3'b111), .S(RegDst[1:0]), .Out(WriteRegOut));
mux4_1 ImmSelMux[15:0] (.InA(SLBIExtRes[15:0]), .InB({11'd0,Inst_F[4:0]}), .InC({{11{Inst_F[4]}},Inst_F[4:0]}), .InD({12'd0,Inst_F[3:0]}), .S(ImmSel[1:0]), .Out(Imm16_D[15:0]));
mux4_1 ALUSpecSel1Mux[1:0] (.InA(2'b00), .InB(2'b01), .InC(2'b10), .InD(2'b11), .S(ALUSpecSel1[1:0]), .Out(ALUSpecSel1Res[1:0])); 

mux2_1 SBLIExtMux[15:0] (.InA({{8{Inst_F[7]}},Inst_F[7:0]}), .InB({8'd0, Inst_F[7:0]}), .S(SLBIExt), .Out(SLBIExtRes));
mux2_1 ALUSpecSel2Mux[1:0] (.InA(Inst_F[1:0]), .InB(ALUSpecSel1Res[1:0]), .S(ALUSpecSel2), .Out(ALUSpecSel2Res[1:0]));

rf_bypass Registers (.read1data(ReadData1), .read2data(ReadData2), .err(errReg), .clk(clk), .rst(rst), .read1regsel(Inst_F[10:8]), .read2regsel(Inst_F[7:5]), .writeregsel(WriteRegIn), .writedata(WriteData_W), .write(WriteRegEnIn & ~DataMemStall));

ALUControl ALUCont (.ALUOp(ALUOp), .SpecOps(ALUSpecSel2Res[1:0]), .ALUControl(ALUControl_D), .err(errALU));

RegIdentifier RegID (.Inst(Inst_F), .Rs(Rs_D), .Rt(Rt_D), .Rd(Rd_D), .RsV(RsV1), .RtV(RtV1), .RdV(RdV_temp));
assign RsV = RsV1;
assign RtV = RtV1;
assign PCInc_D = PCInc_F;
assign ReadData2_D = ReadData2;
assign ReadData1_D = ReadData1;

//////////////////////ADDED VALS//////////////////////////////////////////////
assign Rs_E_temp = Rs_D;
assign Rt_E_temp = Rt_D;


mux2_1 DE_StallMux[116:0] (
	.InA({PCInc_D, AluSrc_D, AluSrc2_D, AluSrc3_D, Imm16_D, ReadData2_D, ReadData1_D,ALUControl_D, JumpR_D, Jump_D, Branch_D, MemWrite_D, MemRead_D, MemToReg_D, Halt_D, WriteRegOut, 			WriteRegEnOut,RdV_temp,Rs_E_temp,Rt_E_temp,RsV1,RtV1,Inst_F}), 
	.InB(117'd0), 
	.S(Flush_E), 
	.Out({PCInc_DEd1, AluSrc_DEd1, AluSrc2_DEd1, AluSrc3_DEd1, Imm16_DEd1, ReadData2_DEd1,ReadData1_DEd1,
	ALUControl_DEd1, JumpR_DEd1, Jump_DEd1, Branch_DEd1, MemWrite_DEd1, MemRead_DEd1, MemToReg_DEd1, Halt_DEd1, WriteRegOutd1, WriteRegEnOutd1,RdV_d1,Rs_Ed1,Rt_Ed1,RsV_DEd1,RtV_DEd1,Inst_DEd1}));

mux2_1 DE_DataMemStall[119:0] (
	.InA({PCInc_DEd1, AluSrc_DEd1, AluSrc2_DEd1, AluSrc3_DEd1, Imm16_DEd1, ReadData2_DEd1, ReadData1_DEd1,
	ALUControl_DEd1, JumpR_DEd1, Jump_DEd1, Branch_DEd1, MemWrite_DEd1, MemRead_DEd1, MemToReg_DEd1, Halt_DEd1, WriteRegOutd1, WriteRegEnOutd1, RdV_d1,Rs_Ed1,Rt_Ed1,RsV_DEd1,RtV_DEd1,Inst_DEd1,Rd_D}),
	.InB({PCInc_DEq, AluSrc_DEq, AluSrc2_DEq, AluSrc3_DEq, Imm16_DEq, ReadData2_DEq, ReadData1_DEq,
	ALUControl_DEq, JumpR_DEq, Jump_DEq, Branch_DEq, MemWrite_DEq, MemRead_DEq, MemToReg_DEq, Halt_DEq, WriteRegOutq, WriteRegEnOutq, RdV,Rs_DEq,Rt_DEq,RsV_DEq,RtV_DEq,Inst_DEq,Rd_E}),
	.S(DataMemStall),
	.Out({PCInc_DEd, AluSrc_DEd, AluSrc2_DEd, AluSrc3_DEd, Imm16_DEd, ReadData2_DEd, ReadData1_DEd,
	ALUControl_DEd, JumpR_DEd, Jump_DEd, Branch_DEd, MemWrite_DEd, MemRead_DEd, MemToReg_DEd, Halt_DEd, WriteRegOutd, WriteRegEnOutd, RdV_d,Rs_Ed,Rt_Ed,RsV_DEd,RtV_DEd,Inst_DEd,Rd_D_temp}));

dff Decode_Execute_dff[119:0] (
	.q({PCInc_DEq, AluSrc_DEq, AluSrc2_DEq, AluSrc3_DEq, Imm16_DEq, ReadData2_DEq, ReadData1_DEq,
	ALUControl_DEq, JumpR_DEq, Jump_DEq, Branch_DEq, MemWrite_DEq, MemRead_DEq, MemToReg_DEq, Halt_DEq, WriteRegOutq, WriteRegEnOutq, RdV,Rs_DEq,Rt_DEq,RsV_DEq,RtV_DEq,Inst_DEq, Rd_E}),
	.d({PCInc_DEd, AluSrc_DEd, AluSrc2_DEd, AluSrc3_DEd, Imm16_DEd, ReadData2_DEd, ReadData1_DEd,
	ALUControl_DEd, JumpR_DEd, Jump_DEd, Branch_DEd, MemWrite_DEd, MemRead_DEd, MemToReg_DEd, Halt_DEd, WriteRegOutd, WriteRegEnOutd, RdV_d,Rs_Ed,Rt_Ed,RsV_DEd,RtV_DEd,Inst_DEd, Rd_D_temp}),
	.clk(clk),
	.rst(rst));
endmodule
