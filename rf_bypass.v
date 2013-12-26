module rf_bypass (
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
	
	wire [15:0] r1, r2;
	wire sel1, sel2;
	
   rf RF(.read1data(r1), .read2data(r2), .err(err), .clk(clk), .rst(rst), 
   			.read1regsel(read1regsel), .read2regsel(read2regsel), .writeregsel(writeregsel), 
   			.writedata(writedata), .write(write));
   assign sel1 = (read1regsel == writeregsel) & write;
   assign sel2 = (read2regsel == writeregsel) & write; 
 
   
   mux2_1 MUX1 [15:0](.InA(r1[15:0]), .InB(writedata[15:0]), .S(sel1), .Out(read1data[15:0]));
   mux2_1 MUX2 [15:0](.InA(r2[15:0]), .InB(writedata[15:0]), .S(sel2), .Out(read2data[15:0]));
   			
   
endmodule
// DUMMY LINE FOR REV CONTROL :1:
