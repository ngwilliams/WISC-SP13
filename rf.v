
/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module rf (
           // Outputs
           read1data, read2data, err,
           // Inputs
           clk, rst, read1regsel, read2regsel, writeregsel, writedata, write
           );
   input clk, rst;
   input [2:0] read1regsel;
   input [2:0] read2regsel;
   input [2:0] writeregsel;
   input [15:0] writedata;
   input        write;

   output [15:0] read1data;
   output [15:0] read2data;
   output        err;

   assign err = 1'b0;
   // your code
   wire [15:0] regOut0, regOut1,regOut2,regOut3,regOut4,regOut5,regOut6,regOut7;
   wire [7:0] en;

   reg_16bit R0 (.In(writedata), .clk(clk), .rst(rst), .en(en[0]), .out(regOut0));
   reg_16bit R1 (.In(writedata), .clk(clk), .rst(rst), .en(en[1]), .out(regOut1));
   reg_16bit R2 (.In(writedata), .clk(clk), .rst(rst), .en(en[2]), .out(regOut2));
   reg_16bit R3 (.In(writedata), .clk(clk), .rst(rst), .en(en[3]), .out(regOut3));
   reg_16bit R4 (.In(writedata), .clk(clk), .rst(rst), .en(en[4]), .out(regOut4));
   reg_16bit R5 (.In(writedata), .clk(clk), .rst(rst), .en(en[5]), .out(regOut5));
   reg_16bit R6 (.In(writedata), .clk(clk), .rst(rst), .en(en[6]), .out(regOut6));
   reg_16bit R7 (.In(writedata), .clk(clk), .rst(rst), .en(en[7]), .out(regOut7));
   
   //Decoders for enable
   decoder3_8 enDecoder(writeregsel,en, write);
   
   //8:1 mux for read1data and read2data
   
   mux8_1 muxRead1Data (.InA(regOut0), .InB(regOut1), .InC(regOut2), .InD(regOut3), .InE(regOut4), .InF(regOut5), .InG(regOut6), .InH(regOut7), .S(read1regsel), .Out(read1data));    

   mux8_1 muxRead2Data (.InA(regOut0), .InB(regOut1), .InC(regOut2), .InD(regOut3), .InE(regOut4), .InF(regOut5), .InG(regOut6), .InH(regOut7), .S(read2regsel), .Out(read2data));
   
endmodule
// DUMMY LINE FOR REV CONTROL :1:
