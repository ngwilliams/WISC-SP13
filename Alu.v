module Alu (
	//Inputs
	A,
	B,
	AluControl,
	//Outputs
	Flag,
	Out);


input [15:0] A,B;
input [13:0] AluControl;
output [15:0] Out;
output Flag;

	
//Setting up ALU input 1, with ability to choose Two's Compliment of Input
wire [15:0] ATwosComp0,ATwosComp1, AluInput1;
//not1 ATwosCompNot [15:0] (.in1(A),.out(ATwosComp0));
assign ATwosComp0 = ~A;
//assign ATwosComp1 = ATwosComp0  + 1'b1;
//adder(A, B, Cin, S, Cout);
fulladder16 TwoCompAdd[15:0] (.A(ATwosComp0), .B(16'd1),.SUM(ATwosComp1));
mux2_1 AluInput1Mux [15:0] (.InA(A), .InB(ATwosComp1), .S(AluControl[13]), .Out(AluInput1));

//Setting up ALU input 2, with ability to choose One's Compliment of Input
wire [15:0] BOnesComp,AluInput2;
//not1 BOnesCompNot [15:0] (.in1(B),.out(BOnesComp));
assign BOnesComp = ~B;

mux2_1 AluInput2Mux [15:0] (.InA(B), .InB(BOnesComp), .S(AluControl[12]), .Out(AluInput2));


//Setting up Shifter
wire [3:0] ShifterCntWire;
wire [15:0] ShifterOut;
mux2_1 ShifterCntMux [3:0] (.InA(AluInput2[3:0]), .InB(4'b1000), .S(AluControl[1]), .Out(ShifterCntWire));

shifter AluShifter (.In(AluInput1),.Cnt(ShifterCntWire),.Op(AluControl[3:2]),.Out(ShifterOut));


//Setting up CLA
wire [15:0] CLAInputBMuxOut, CLASum;
wire CLACout, CLAOverflow;
mux2_1 CLAInputBMux [15:0] (.InA(AluInput2), .InB(16'b0000_0000_0000_0000), .S(AluControl[11]), .Out(CLAInputBMuxOut));

CLA_16_bit AluCLA (.A(AluInput1), .B(CLAInputBMuxOut), .Cin(1'b0), .sign(1'b1), .Sum(CLASum), .Cout(CLACout), .OFL(CLAOverflow));




//Trying to use bitwise operators
//AND
wire [15:0] AndAluInput1and2;
assign AndAluInput1and2 = AluInput1 & AluInput2;
//OR
wire [15:0] XorAluInput1and2;
assign XorAluInput1and2 = AluInput1 ^ AluInput2;
wire [15:0] OrAluInput2andShifterOut, AluInput2LSB8;
assign AluInput2LSB8 = {8'b0000_0000,AluInput2[7:0]};
assign OrAluInput2andShifterOut = AluInput2LSB8 | ShifterOut;
//Setting up BTR

wire [15:0] BTROut;
BTR AluBTR (.A(AluInput1),.B(BTROut));

//Setting up selFlag Mux with following inputs
//00 - EQ
//01 - NEQ
//10 - GE
//11 - LT
wire EQ, NEQ, GE, LT, SelFlagMuxOut;
//not1 CLASumMsbNot (.in1(CLASum[15]), .out(CLASumMsbNotOut));
assign LT = CLASum[15]; 
assign GE = ~CLASum[15];

//or16 NOR16 (.in(CLASum[15:0]), .out(EQ));
assign EQ = ~|CLASum[15:0];
//not1 CLASumNorNot (.in1(CLASumNor),.out(CLASumNorNotOut));
assign NEQ = ~EQ;

mux4_1 selFlagMux (.InA(EQ), .InB(NEQ), .InC(GE), .InD(LT), .S(AluControl[10:9]), .Out(SelFlagMuxOut));

assign Flag = SelFlagMuxOut;

//Setting up Logic and mux for Sel Flag 2 Logic
//Liogic

//Trying to do upper right in bitwise operators
wire LE;
assign LE = ~LT | EQ;
//GE AND NEQ
wire LT2;
assign LT2 = NEQ & GE;


//2to 1 mux for SelFlag2
//0 - LTLENorNotOut
//1 - GENEQNandNotOut

mux2_1 LT2SelMux	(.InA(LT2), .InB(~(AluInput1[15] & AluInput2[15])), .S(AluInput1[15] & AluInput2[15]), .Out(LT2SelMuxOut));
mux2_1 LESelMux	(.InA(LE), .InB(~(AluInput1[15] & AluInput2[15])), .S(AluInput1[15] & AluInput2[15]), .Out(LESelMuxOut));

mux2_1 LT2SelMux2	(.InA(LT2SelMuxOut), .InB(~AluInput1[15] & ~AluInput2[15] & NEQ), .S(~AluInput1[15] & ~AluInput2[15] & NEQ), .Out(LT2SelMuxOut2));
mux2_1 LESelMux2	(.InA(LESelMuxOut), .InB(~AluInput1[15] & ~AluInput2[15]), .S(~AluInput1[15] & ~AluInput2[15]), .Out(LESelMuxOut2));

mux2_1 LT2SelMux3	(.InA(LT2SelMuxOut2), .InB(A[15] & AluInput1[15] & NEQ), .S(A[15] & AluInput1[15] & NEQ), .Out(LT2SelMuxOut3));
mux2_1 LESelMux3	(.InA(LESelMuxOut2), .InB(A[15] & AluInput1[15] & CLASum[15]), .S(A[15] & AluInput1[15] & CLASum[15]), .Out(LESelMuxOut3));

wire SL;
mux2_1 SLMux (.InA(LESelMuxOut3), .InB(LT2SelMuxOut3), .S(AluControl[0]), .Out(SL));

//Setting up 8 to 1 mux for SelFunc with following inputs
//000 - ShifterOut
//001 - Carry Out of CLA
//010 - CLASum
//011 - NandNotOut
//100 - XorNotOut
//101 - BTROut
//110 - Immediate(B)
//111 - XorShiftAlu2NotOut

wire [15:0] SelFuncMuxOut;
//Fittting for mux size errors
wire [15:0] CLACout16;
assign CLACout16 = {{15'b000000000000000}, CLACout};
//assign XorNotOut16 = {{15'b000000000000000}, XorNotOut};
//assign XorShiftAlu2NotOut16 = {{15'b000000000000000}, XorShiftAlu2NotOut};


mux8_1 SelFuncMux [15:0] (.InA(ShifterOut),.InB(CLACout16),.InC(CLASum),.InD(AndAluInput1and2), .InE(XorAluInput1and2), .InF(BTROut), .InG(AluInput2), .InH(OrAluInput2andShifterOut), .S(AluControl[8:6]), .Out(SelFuncMuxOut));

// Set up mux that leads to outside of ALU!!!!!! Based on SelOut
mux4_1 AluOutMux [15:0] (.InA(1'b0), .InB({{15{1'd0}},SelFlagMuxOut}), .InC({{15{1'd0}},SL}), .InD(SelFuncMuxOut), .S(AluControl[5:4]), .Out(Out));


endmodule





