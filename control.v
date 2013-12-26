module control(OpCode, RegDst, MemRead, MemToReg, AluOp, MemWrite, AluSrc, AluSrc2, AluSrc3, RegWrite, Jump, Branch, JumpR, Halt, ImmSel, SLBIExt, AluSpecSel1, AluSpecSel2);

input[4:0] OpCode;
output reg[1:0] RegDst, ImmSel, AluSpecSel1;
output reg MemRead, MemToReg, MemWrite, AluSrc, AluSrc2, AluSrc3, RegWrite, Jump, Branch, JumpR, Halt, SLBIExt, AluSpecSel2;
output reg[3:0] AluOp;


always @ (OpCode)
case(OpCode)

5'b00000: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0000;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b0;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b1;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b00001: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0000;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b0;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

//5'b00010: begin

//end
/////////////////////////////////

//5'b00011: begin

//end
/////////////////////////////////

5'b00100: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0000;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b0;
Jump = 1'b1;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b00101: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0000;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b0;
Jump = 1'b1;
Branch =1'b0;
JumpR = 1'b1;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b00110: begin
RegDst = 2'b11;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b1110;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b1;
AluSrc3 = 1'b1;
RegWrite = 1'b1;
Jump = 1'b1;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b00111: begin
RegDst = 2'b11;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b1110;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b1;
AluSrc3 = 1'b1;
RegWrite = 1'b1;
Jump = 1'b1;
Branch =1'b0;
JumpR = 1'b1;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b01000: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0100;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b10;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b01001: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0100;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b10;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b01;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b01010: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0100;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b01;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b10;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b01011: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0100;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b01;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b11;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b01100: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0110;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b0;
Jump = 1'b0;
Branch =1'b1;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b01101: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0111;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b0;
Jump = 1'b0;
Branch =1'b1;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b01110: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b1000;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b0;
Jump = 1'b0;
Branch =1'b1;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b01111: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b1001;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b0;
Jump = 1'b0;
Branch =1'b1;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b10000: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0100;
MemWrite = 1'b1;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b0;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b10;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b10001: begin
RegDst = 2'b00;
MemRead = 1'b1;
MemToReg = 1'b1;
AluOp = 4'b0100;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b10;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b10010: begin
RegDst = 2'b01;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0010;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b1;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b10011: begin
RegDst = 2'b01;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0100;
MemWrite = 1'b1;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b10;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b10100: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0101;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b11;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b10101: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0101;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b11;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b01;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b10110: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0101;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b11;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b10;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b10111: begin
RegDst = 2'b00;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0101;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b11;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b11;
AluSpecSel2 = 1'b1;
end
/////////////////////////////////

5'b11000: begin
RegDst = 2'b01;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0001;
MemWrite = 1'b0;
AluSrc = 1'b1;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b11001: begin
RegDst = 2'b10;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0011;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b11010: begin
RegDst = 2'b10;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0101;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b11011: begin
RegDst = 2'b10;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b0100;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b11100: begin
RegDst = 2'b10;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b1011;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b11101: begin
RegDst = 2'b10;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b1100;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b11110: begin
RegDst = 2'b10;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b1101;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

5'b11111: begin
RegDst = 2'b10;
MemRead = 1'b0;
MemToReg = 1'b0;
AluOp = 4'b1010;
MemWrite = 1'b0;
AluSrc = 1'b0;
AluSrc2 = 1'b0;
AluSrc3 = 1'b0;
RegWrite = 1'b1;
Jump = 1'b0;
Branch =1'b0;
JumpR = 1'b0;
Halt = 1'b0;
ImmSel = 2'b00;
SLBIExt = 1'b0;
AluSpecSel1 = 2'b00;
AluSpecSel2 = 1'b0;
end
/////////////////////////////////

default: begin
RegDst = 1'bz;
MemRead = 1'bz;
MemToReg = 1'bz;
AluOp = 4'bzzzz;
MemWrite = 1'bz;
AluSrc = 1'bz;
AluSrc2 = 1'bz;
AluSrc3 = 1'bz;
RegWrite = 1'bz;
Jump = 1'bz;
Branch =1'bz;
JumpR = 1'bz;
Halt = 1'bz;
ImmSel = 2'bzz;
SLBIExt = 1'bz;
AluSpecSel1 = 2'bzz;
AluSpecSel2 = 1'bz;
end
endcase
endmodule
