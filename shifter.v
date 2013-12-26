module shifter (In, Cnt, Op, Out);
   
   input [15:0] In;
   input [3:0]  Cnt;
   input [1:0]  Op;
   output [15:0] Out;
   wire[15:0] out1, out2, out3, out4;

Rotate_Lshifter ROTATE_L (In[15:0], Cnt[3:0], out1[15:0]);
Shift_Lshifter SHIFT_L (In[15:0], Cnt[3:0], out2[15:0]);
Rotate_Rshifter ROR (In[15:0], Cnt[3:0], out3[15:0]);
Logical_Rshifter LOGICAL_R (In[15:0], Cnt[3:0], out4[15:0]);

mux4_1 MUX_FINAL[15:0] (out1[15:0], out2[15:0], out3[15:0], out4[15:0], Op[1:0], Out[15:0]);

endmodule

