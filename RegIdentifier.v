module RegIdentifier(Inst, Rs, Rt, Rd, RsV, RtV, RdV);

input [15:0] Inst;
output reg [2:0] Rs, Rt, Rd;
output reg RsV, RtV, RdV;

always @ (Inst)
case(Inst[15:11])

5'b00000: begin
Rs = 3'b000;//don't cares
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b0;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b00001: begin
//Rs = 3'b000;
//Rt = 3'b000;
//Rd = 3'b000;
//RsV = 1'b0;
//RtV = 1'b0;
//RdV = 1'b0;
Rs = 3'b000;
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b0;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b00010: begin
Rs = 3'b000;
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b0;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b00011: begin //NOP
Rs = 3'b000;
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b0;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b00100: begin
Rs = 3'b000;
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b0;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b00101: begin //JR
Rs = Inst[10:8];
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b00110: begin //JAL 
Rs = 3'b000;
Rt = 3'b111;
Rd = 3'b111;  //Hard Coded 7
RsV = 1'b0;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b00111: begin  //JALR
Rs = Inst[10:8];
Rt = 3'b111;
Rd = 3'b111;    /// HARD CODED 7
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b01000: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b01001: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b01010: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b01011: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b01100: begin //BEQz
Rs = Inst[10:8];
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b01101: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b01110: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b01111: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = 3'b000;
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b0;
end
/////////////////////////////////

5'b10000: begin//special case ST
Rs = Inst[10:8];
Rt = Inst[7:5];
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b10001: begin // Special Case LD
Rs = Inst[10:8];
Rt = Inst[7:5];
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b10010: begin//special case
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[10:8];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b10011: begin//special case STU
Rs = Inst[10:8];
Rt = Inst[7:5];
Rd = Inst[10:8];//used to be 7:5
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b10100: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b10101: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b10110: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b10111: begin
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[7:5];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b11000: begin //LBI
Rs = 3'b000;
Rt = 3'b000;
Rd = Inst[10:8];
RsV = 1'b0;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b11001: begin //BTR
Rs = Inst[10:8];
Rt = 3'b000;
Rd = Inst[4:2];
RsV = 1'b1;
RtV = 1'b0;
RdV = 1'b1;
end
/////////////////////////////////

5'b11010: begin
Rs = Inst[10:8];
Rt = Inst[7:5];
Rd = Inst[4:2];
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b11011: begin
Rs = Inst[10:8];
Rt = Inst[7:5];
Rd = Inst[4:2];
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b11100: begin
Rs = Inst[10:8];
Rt = Inst[7:5];
Rd = Inst[4:2];
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b11101: begin
Rs = Inst[10:8];
Rt = Inst[7:5];
Rd = Inst[4:2];
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b11110: begin
Rs = Inst[10:8];
Rt = Inst[7:5];
Rd = Inst[4:2];
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

5'b11111: begin
Rs = Inst[10:8];
Rt = Inst[7:5];
Rd = Inst[4:2];
RsV = 1'b1;
RtV = 1'b1;
RdV = 1'b1;
end
/////////////////////////////////

default: begin
Rs = 3'bzzz;
Rt = 3'bzzz;
Rd = 3'bzzz;
RsV = 1'bz;
RtV = 1'bz;
RdV = 1'bz;
end
endcase
endmodule
