module HazardDetectionUnit(
	input MemToRegE, //execute
	input [2:0] RsD, //Decode
	input [2:0] RtD, //Decode
	input [2:0] RdE, //Execute
	input [2:0] RdM, //Memory
	input [2:0] RdWB,//WB
	input [2:0] RsE,
	input [2:0] RtE,
	input [2:0] RsM,
	input [2:0] RsWB,
	input RsVM,
	input MemToRegM, //Memory
	input MemToRegWB,
	input MemReadE,
	input MemReadM,
	input MemReadWB,
	input MemWriteE,
	input MemWriteM,
	input MemWriteWB,
	input RsVD, //Rs Register Valid Bit From DECODE
	input RtVD, //Rt Register Valid Bit FROM DECODE
	input RdVE, //Rd Register Valid Bit FROM EXECUTE
	input RdVM, //Rd Register Valid Bit FROM MEMORY
	input RdVWB, //RdVALID WB
	input RsVE,
	input RtVE,
	input RsVWB,
	// END of required signals for RAW STALL
	input BranchD,
	input BranchE,
	input JumpD,
	input JumpE,
	input BranchEF,
	input RegWriteM,
	input WriteRegE,
	input DataMemStall,
	//End of Signals for Branch Control
	output StallF,
	output StallD,
	output FlushE,
	output BranchNOPF, //sed for setting next decode stage to NOP instruction in case of Branch INSTR
	output BranchTaken	
);
/////////////////////////////////////////////////////////////////////////////////////////////
//RAW STALL SECTION//
wire RAWStall, LWStall1;
assign RAWStall = LWStall1; 

assign LWStall1 = ((MemReadE | MemReadM));

//ASSIGN OUTPUTS
assign StallF = RAWStall | JumpD | DataMemStall; // if memory is not ready, stall, 
assign StallD = RAWStall | BranchTaken | DataMemStall;
assign FlushE = RAWStall | BranchTaken;
assign BranchNOPF = JumpD | JumpE;
assign BranchTaken = BranchEF;
endmodule
