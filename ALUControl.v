module ALUControl(ALUOp, SpecOps, ALUControl, err);

input[3:0] ALUOp;
input[1:0] SpecOps;
output reg[13:0] ALUControl;
output reg err;

always @ (ALUOp, SpecOps)
casex({ALUOp, SpecOps})
6'b0000_??: begin
ALUControl = 14'b00000000000000;
err = 1'b0;
end
/////////////////////////////////
6'b0001_??: begin
ALUControl = 14'b00000110110000;
err = 1'b0;
end
/////////////////////////////////

6'b0010_??: begin
ALUControl = 14'b00000111110110;
err = 1'b0;
end
/////////////////////////////////

6'b0011_??: begin
ALUControl = 14'b00000101110000;
err = 1'b0;
end
/////////////////////////////////

6'b0100_00: begin
ALUControl = 14'b00000010110000;
err = 1'b0;
end
/////////////////////////////////

6'b0100_01: begin
ALUControl = 14'b10000010110000;
err = 1'b0;
end
/////////////////////////////////

6'b0100_10: begin
ALUControl = 14'b00000100110000;
err = 1'b0;
end
/////////////////////////////////

6'b0100_11: begin
ALUControl = 14'b01000011110000;
err = 1'b0;
end
/////////////////////////////////

6'b0101_00: begin
ALUControl = 14'b00000000110000;
err = 1'b0;
end
/////////////////////////////////

6'b0101_01: begin
ALUControl = 14'b00000000110100;
err = 1'b0;
end
/////////////////////////////////

6'b0101_10: begin
ALUControl = 14'b00000000111000;
err = 1'b0;
end
/////////////////////////////////

6'b0101_11: begin
ALUControl = 14'b00000000111100;
err = 1'b0;
end
/////////////////////////////////

6'b0110_??: begin
ALUControl = 14'b00100000010000;
err = 1'b0;
end
/////////////////////////////////

6'b0111_??: begin
ALUControl = 14'b00101000010000;
err = 1'b0;
end
/////////////////////////////////

6'b1000_??: begin
ALUControl = 14'b00111000010000;
err = 1'b0;
end
/////////////////////////////////

6'b1001_??: begin
ALUControl = 14'b00110000010000;
err = 1'b0;
end
/////////////////////////////////

6'b1010_??: begin
ALUControl = 14'b00000001110000;
err = 1'b0;
end
/////////////////////////////////

6'b1011_??: begin
ALUControl = 14'b10000000010000;
err = 1'b0;
end
/////////////////////////////////

6'b1100_??: begin
ALUControl = 14'b10011000100001;
err = 1'b0;
end
/////////////////////////////////

6'b1101_??: begin
ALUControl = 14'b10000000100000;
err = 1'b0;
end
/////////////////////////////////

6'b1110_??: begin
ALUControl = 14'b00100010110000;
err = 1'b0;
end
/////////////////////////////////

default: begin
ALUControl = 14'bzzzzzzzzzzzzzz;
err = 1'b1;
end
endcase
endmodule
