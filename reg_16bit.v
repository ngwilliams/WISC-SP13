module reg_16bit(input [15:0] In, input clk, input rst, input en, output [15:0] out);


wire [15:0] muxToReg;


mux2_1 mux0 (.InA(out[0]), .InB(In[0]), .S(en), .Out(muxToReg[0]));
dff dff0(.q(out[0]), .d(muxToReg[0]),.clk(clk), .rst(rst));

mux2_1 mux1 (.InA(out[1]), .InB(In[1]), .S(en), .Out(muxToReg[1]));
dff dff1(.q(out[1]), .d(muxToReg[1]),.clk(clk), .rst(rst));

mux2_1 mux2 (.InA(out[2]), .InB(In[2]), .S(en), .Out(muxToReg[2]));
dff dff2(.q(out[2]), .d(muxToReg[2]),.clk(clk), .rst(rst));

mux2_1 mux3 (.InA(out[3]), .InB(In[3]), .S(en), .Out(muxToReg[3]));
dff dff3(.q(out[3]), .d(muxToReg[3]),.clk(clk), .rst(rst));

mux2_1 mux4 (.InA(out[4]), .InB(In[4]), .S(en), .Out(muxToReg[4]));
dff dff4(.q(out[4]), .d(muxToReg[4]),.clk(clk), .rst(rst));

mux2_1 mux5 (.InA(out[5]), .InB(In[5]), .S(en), .Out(muxToReg[5]));
dff dff5(.q(out[5]), .d(muxToReg[5]),.clk(clk), .rst(rst));

mux2_1 mux6 (.InA(out[6]), .InB(In[6]), .S(en), .Out(muxToReg[6]));
dff dff6(.q(out[6]), .d(muxToReg[6]),.clk(clk), .rst(rst));

mux2_1 mux7 (.InA(out[7]), .InB(In[7]), .S(en), .Out(muxToReg[7]));
dff dff7(.q(out[7]), .d(muxToReg[7]),.clk(clk), .rst(rst));

mux2_1 mux8 (.InA(out[8]), .InB(In[8]), .S(en), .Out(muxToReg[8]));
dff dff8(.q(out[8]), .d(muxToReg[8]),.clk(clk), .rst(rst));

mux2_1 mux9 (.InA(out[9]), .InB(In[9]), .S(en), .Out(muxToReg[9]));
dff dff9(.q(out[9]), .d(muxToReg[9]),.clk(clk), .rst(rst));

mux2_1 mux10 (.InA(out[10]), .InB(In[10]), .S(en), .Out(muxToReg[10]));
dff dff10(.q(out[10]), .d(muxToReg[10]),.clk(clk), .rst(rst));

mux2_1 mux11 (.InA(out[11]), .InB(In[11]), .S(en), .Out(muxToReg[11]));
dff dff11(.q(out[11]), .d(muxToReg[11]),.clk(clk), .rst(rst));

mux2_1 mux12 (.InA(out[12]), .InB(In[12]), .S(en), .Out(muxToReg[12]));
dff dff12(.q(out[12]), .d(muxToReg[12]),.clk(clk), .rst(rst));

mux2_1 mux13 (.InA(out[13]), .InB(In[13]), .S(en), .Out(muxToReg[13]));
dff dff13(.q(out[13]), .d(muxToReg[13]),.clk(clk), .rst(rst));

mux2_1 mux14 (.InA(out[14]), .InB(In[14]), .S(en), .Out(muxToReg[14]));
dff dff14(.q(out[14]), .d(muxToReg[14]),.clk(clk), .rst(rst));

mux2_1 mux15 (.InA(out[15]), .InB(In[15]), .S(en), .Out(muxToReg[15]));
dff dff15(.q(out[15]), .d(muxToReg[15]),.clk(clk), .rst(rst));



endmodule
