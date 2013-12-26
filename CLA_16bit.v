
module CLA_16_bit(input [15:0] A,B,input Cin, input sign, output [15:0] Sum,output Cout, output OFL);

wire c3,p3,g3, c7,p7,g7, c11,p11,g11, p15,g15; //Wires for interconnections

CLA_4_bit CLA1(Sum[3:0],c3,p3,g3,A[3:0],B[3:0],Cin);

CLA_4_bit CLA2(Sum[7:4],c7,p7,g7,A[7:4],B[7:4],c3);

CLA_4_bit CLA3(Sum[11:8],c11,p11,g11,A[11:8],B[11:8],c7);

CLA_4_bit CLA4(Sum[15:12],Cout,p15,g15,A[15:12],B[15:12],c11);



//assign unsignedOFL = Cout;
//assign signedOFL1 = (A[15] & B[15]) ? 1'b1 : 1'b0;//both negative
//assign signedOFL2 = (A[15] | B[15] == 0) ? 1'b1 : 1'b0;//both positive
//assign signedOFL3 = (Sum[15] & signedOFL1 == 0) ? 1'b1 : 1'b0;//
//assign signedOFL4 = (Sum[15] | signedOFL2) ? 1'b1 : 1'b0;

//assign OFL = (sign) ? (signedOFL3 | signedOFL4) : unsignedOFL;
assign OFL = ((A[15]&B[15])^Sum[15]);

endmodule
