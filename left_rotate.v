module Rotate_Lshifter (In, Cnt, Out);
   
   input [15:0] In;
   input [3:0]  Cnt;
   output [15:0] Out;
   wire [15:0] First_Out, Second_Out, Third_Out;

mux2_1 MUX1[15:0] (In[15:0], {In[14:0], In[15]}, Cnt[0], First_Out[15:0]);
mux2_1 MUX2[15:0] (First_Out[15:0], {First_Out[13:0], First_Out[15:14]}, Cnt[1], Second_Out[15:0]);
mux2_1 MUX3[15:0] (Second_Out[15:0], {Second_Out[11:0], Second_Out[15:12]}, Cnt[2], Third_Out[15:0]);
mux2_1 MUX4[15:0] (Third_Out[15:0], {Third_Out[7:0], Third_Out[15:8]}, Cnt[3], Out[15:0]);

endmodule
