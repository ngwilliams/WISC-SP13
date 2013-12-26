/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
wire[15:0] PCInc_FDq, Inst_FDq, NextPC_EF, JumpReg_DE, JumpImm_DE, PCInc_DE,
	 ReadData2_DE, ReadData1_DE,  WriteData_WD, ALUResult_EM, AluInput2ForwardMuxOut_EM,
		MemReadData_MWq, ALUResult_MWq, Imm16_D,Inst_D;
wire [13:0] ALUControl_DE; 
wire 	JumpR_DE, Jump_DE, Branch_DE,Jump_D, Branch_D, MemWrite_DE, MemRead_DE, MemToReg_DE, Halt_DE, MemWrite_EM,
		MemRead_EM, MemToReg_EM, Halt_EM, Stall_D, Flush_E, BranchNOPF;
wire [2:0] WriteReg_DE, WriteReg_EM, WriteReg_MWq, WriteReg_WD, Rs_D, Rt_D, Rd_E, Rd_EM,Rd_MWq, Rs_E,Rt_E,Rs_M,Rs_WB;
wire WriteRegEn_DE, WriteRegEn_EM, WriteRegEn_MWq, WriteRegEn_WD, Stall_F, RsV_DE, RtV_DE, RdV_DE, RdV_EM, Inst_F_Validq, Halt_MWq, Halt_WM, BranchEF, AluSrc_D, AluSrc2_D, AluSrc3_D,RdV_MWq,MemWrite_MWq,BranchTaken,RsV_M,RsV_WB, errF, errD, errE, errM,DataMemStall;
	
assign err = errF | errD | errE | errM;

I_Fetch IF (
	//Outputs
	.err(errF),
	.PCInc_FDq(PCInc_FDq),
	.Inst_FDq(Inst_FDq),
	.Inst_F_Validq(Inst_F_Validq), //Added Valid signal to set control unit in Decode
	//Inputs
	.NextPC_E(NextPC_EF),
	.Stall_F(Stall_F),
	.Branch(BranchTaken),
	.Jump(Jump_DE),
	.clk(clk),
	.rst(rst),
	.BranchNOPF(BranchNOPF),
	.Stall_D(Stall_D),
	.DataMemStall(DataMemStall)
	);
		
I_Decode ID (
	//Outputs
	.PCInc_DEq(PCInc_DE),
	.ReadData1_DEq(ReadData1_DE),
	.ReadData2_DEq(ReadData2_DE),
	.ALUControl_DEq(ALUControl_DE),
	.JumpR_DEq(JumpR_DE),
	.Jump_DEq(Jump_DE),
	.Branch_DEq(Branch_DE),
	.MemWrite_DEq(MemWrite_DE),
	.MemRead_DEq(MemRead_DE),
	.MemToReg_DEq(MemToReg_DE),
	.Halt_DEq(Halt_DE),
	.WriteRegOutq(WriteReg_DE),
	.WriteRegEnOutq(WriteRegEn_DE),
	.Rs_D(Rs_D),
	.Rt_D(Rt_D),
	.Rd_E(Rd_E),
	.Rs_DEq(Rs_E),
	.Rt_DEq(Rt_E), 
	.RsV(RsV_E),
	.RtV(RtV),
	.RdV(RdV_DE),
	.RsV_DEq(RsV_DE),
	.RtV_DEq(RtV_DE),	
	.err(errD),
	.Branch_DEd(Branch_D),
	.Jump_DEd(Jump_D),
	.AluSrc_DEq(AluSrc_D), 
	.AluSrc2_DEq(AluSrc2_D),
	.AluSrc3_DEq(AluSrc3_D),
 	.Imm16_DEq(Imm16_D),
	.Inst_DEq(Inst_D),
	//Inputs
	.PCInc_F(PCInc_FDq),
	.WriteData_W(WriteData_WD),
	.Inst_F(Inst_FDq),
	.WriteRegIn(WriteReg_WD),
	.WriteRegEnIn(WriteRegEn_WD),
	.Inst_F_Valid(Inst_F_Validq),
	.clk(clk),
	.rst(rst),
	.Flush_E(Flush_E),
	.DataMemStall(DataMemStall)
	);

I_Execute EX (
	//Outputs
	.NextPC_E(NextPC_EF),
	.AluResult_EMq(ALUResult_EM),
	.AluInput2ForwardMuxOutq(AluInput2ForwardMuxOut_EM),
	.MemWrite_EMq(MemWrite_EM),
	.MemRead_EMq(MemRead_EM),
	.MemToReg_EMq(MemToReg_EM),
	.Halt_EMq(Halt_EM),
	.WriteReg_EMq(WriteReg_EM),
	.WriteRegEn_EMq(WriteRegEn_EM),
	.Rd_EMq(Rd_EM),
	.RdV_EMq(RdV_EM),
	.err(errE),
	.BranchEF(BranchEF),
	.Rs_M(Rs_M),
	.RsV_M(RsV_M),
	//Inputs
	.JumpReg_D(JumpReg_DE),
	.JumpImm_D(JumpImm_DE),
	.PCInc_D(PCInc_DE),
	.ReadData1_D(ReadData1_DE),
	.ReadData2_D(ReadData2_DE),
	.AluControl_D(ALUControl_DE),
	.JumpR_D(JumpR_DE),
	.Jump_D(Jump_DE),
	.Branch_D(Branch_DE),
	.MemWrite_D(MemWrite_DE),
	.MemRead_D(MemRead_DE),
	.MemToReg_D(MemToReg_DE),
	.Halt_D(Halt_DE),
	.WriteRegIn(WriteReg_DE),
	.WriteRegEnIn(WriteRegEn_DE),
	.RdIn(Rd_E),
	.RdVIn(RdV_DE),
	.AluSrc_D(AluSrc_D),
	.AluSrc2_D(AluSrc2_D),
	.AluSrc3_D(AluSrc3_D),
	.Imm16_D(Imm16_D),
	.AluResultWB(ALUResult_MWq),
	.AluResultM(ALUResult_EM),
	.clk(clk),
	.rst(rst),
	.Inst_D(Inst_D),
	.Rs_E(Rs_E),
	.RsV_E(RsV_DE),
	.WriteData_W(WriteData_WD),//added by N
	.ALUResult_E(ALUResult_EM),//added by N
	.Rt_E(Rt_E),
	.WriteReg_MW(WriteRegEn_MWq),
	.Rd_MW(Rd_MWq),
	.Rs_MW(Rs_WB),
	.RsV_MW(RsV_WB),
	.DataMemStall(DataMemStall),
	.RtV_E(RtV_DE),
	.RdV_M(RdV_EM),
	.RdV_WB(RdV_MWq)
);

I_Memory MEM (
	//Outputs
	.MemReadData_M(MemReadData_MWq),
	.AluResult_M(ALUResult_MWq),
	.MemToReg_M(MemToReg_MWq),
	.WriteRegOut(WriteReg_MWq),
	.WriteRegEnOut(WriteRegEn_MWq),
	.Halt_W(Halt_MWq),
	.Rd_M(Rd_MWq),
	.RdV_M(RdV_MWq),
	.MemRead_M(MemRead_MWq),
	.Rs_WB(Rs_WB),
	.RsV_WB(RsV_WB),
	.MemWrite_M(MemWrite_MWq),
	.err(errM),
	.DataMemStall(DataMemStall),
	//Inputs
	.AluResult_E(ALUResult_EM),
	.ReadData2_E(AluInput2ForwardMuxOut_EM),
	.MemWrite_E(MemWrite_EM),
	.MemRead_E(MemRead_EM),
	.MemToReg_E(MemToReg_EM),
	.Halt_E(Halt_EM),
	.WriteRegIn(WriteReg_EM),
	.WriteRegEnIn(WriteRegEn_EM),
	.Halt_WIn(Halt_WM),
	.Rs_M(Rs_M),
	.RsV_M(RsV_M),
	.Rd_EM(Rd_EM),
	.RdV_EM(RdV_EM),
	.clk(clk),
	.rst(rst)
);

I_WriteBack WB (
	//Outputs
	.WriteData_W(WriteData_WD),
	.WriteRegOut(WriteReg_WD),
	.WriteRegEnOut(WriteRegEn_WD),
	.Halt_Out(Halt_WM),
	//Inputs
	.MemReadData_M(MemReadData_MWq),
	.AluResult_M(ALUResult_MWq),
	.MemToReg_M(MemToReg_MWq),
	.WriteRegIn(WriteReg_MWq),
	.WriteRegEnIn(WriteRegEn_MWq),
	.Halt_W(Halt_MWq)
);

HazardDetectionUnit hdu(
	.MemToRegE(MemToReg_DE), //execute
	.RsD(Rs_D), //Decode
	.RtD(Rt_D), //Decode
	.RdE(Rd_E), //Execute
	.RdM(Rd_EM), //Memory
	.RdWB(Rd_MWq), //WB
	.RsE(Rs_E),
	.RtE(Rt_E),
	.RsM(Rs_M),
	.RsVM(RsV_M),
	.RsWB(Rs_WB),
	.RsVWB(RsV_WB),
	.MemToRegM(MemToReg_EM), //Memory
	.MemToRegWB(MemToReg_MWq),
	.MemReadE(MemRead_DE),
	.MemReadM(MemRead_EM),
	.MemReadWB(MemRead_MWq),
	.MemWriteE(MemWrite_DE),
	.MemWriteM(MemWrite_EM),
	.MemWriteWB(MemWrite_MWq),
	.RegWriteM(WriteRegEn_EM),
	.RsVD(RsV_DE), //Rs Register Valid Bit From DECODE
	.RtVD(RtV_DE), //Rt Register Valid Bit FROM DECODE
	.RdVE(RdV_DE), //Rd Register Valid Bit FROM EXECUTE
	.RdVM(RdV_EM), //Rd Register Valid Bit FROM MEMORY
	.RdVWB(RdV_MWq), //RD Valid WB
	.RsVE(RsV_DE),
	.RtVE(RtV_DE),
	.WriteRegE(WriteRegEn_DE),
	.BranchD(Branch_D),
	.BranchE(Branch_DE),
	.BranchEF(BranchEF),
	.JumpD(Jump_D),
	.JumpE(Jump_DE),
	.StallF(Stall_F),
	.StallD(Stall_D),
	.FlushE(Flush_E),
	.BranchNOPF(BranchNOPF),//for setting next decode stage to NOP instruction in case of BranchINSTR
	.BranchTaken(BranchTaken),
	.DataMemStall(DataMemStall)
	);


endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:

