module mux8_1 (InA, InB, InC, InD, InE, InF, InG, InH, S, Out);

input[15:0] InA, InB, InC, InD, InE, InF, InG, InH;
input[2:0] S;
output[15:0] Out;

wire[15:0] out1, out2;

mux4_1 mux41 [15:0] (.InA(InA), .InB(InB), .InC(InC), .InD(InD), .S(S[1:0]), .Out(out1));
mux4_1 mux42 [15:0] (.InA(InE), .InB(InF), .InC(InG), .InD(InH), .S(S[1:0]), .Out(out2));

mux2_1 mux21 [15:0] (.InA(out1), .InB(out2), .S(S[2]), .Out(Out));
endmodule
