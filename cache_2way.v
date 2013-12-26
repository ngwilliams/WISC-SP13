module cache_2way (
              input enable,
              input clk,
              input rst,
              input createdump,
              input [4:0] tag_in,
              input [7:0] index,
              input [2:0] offset,
              input [15:0] data_in,
              input comp,
              input write,
              input valid_in,

              output [4:0] tag_out,
              output [15:0] data_out,
              output hit,
              output dirty,
              output valid,
              output err
              );
   parameter mem_type = 0;
   
   
   wire 	     A;
   wire              A_now;
   wire 	     v0;
   wire 	     v1;
   wire 	     d0;
   wire 	     d1;
   wire 	     vw;
   wire [4:0] 	     c0_tag_out;
   wire [4:0]        c1_tag_out;
   wire [15:0] 	     c0_data_out;
   wire [15:0] 	     c1_data_out;
   wire 	     c0_hit;
   wire 	     c1_hit;
   wire 	     c0_err;
   wire 	     c1_err;
   wire [15:0] 	     comp_data_out;

   wire 	     v0_ffed;
   wire 	     v1_ffed;
   
   
   dffe victim_way(
		.d(~vw),
		.q(vw),
		.en(comp & hit & valid),
		.clk(clk),
		.rst(rst)
		);
   
   dffe v0_ff(
      	   .d(v0),
	   .q(v0_ffed),
	   .en(comp),
	   .clk(clk),
	   .rst(rst)
	   );

   dffe v1_ff(
      	   .d(v1),
	   .q(v1_ffed),
	   .en(comp),
	   .clk(clk),
	   .rst(rst)
	   );
   
   
   assign A = (v0_ffed & vw) | (v0_ffed & ~v1_ffed);
   assign A_now = (v0 & vw) | (v0 & ~v1);

   cache #(0 + mem_type) c0(
      .enable(comp ? enable : ~A),
      .clk(clk),
      .rst(rst),
      .createdump(createdump),
      .tag_in(tag_in),
      .index(index),
      .offset(offset),
      .data_in(data_in),
      .comp(comp),
      .write(write),
      .valid_in(valid_in),

      .tag_out(c0_tag_out),
      .data_out(c0_data_out),
      .hit(c0_hit),
      .dirty(d0),
      .valid(v0),
      .err(c0_err)
   );

   cache #(2 + mem_type) c1(
      .enable(comp ? enable : A),
      .clk(clk),
      .rst(rst),
      .createdump(createdump),
      .tag_in(tag_in),
      .index(index),
      .offset(offset),
      .data_in(data_in),
      .comp(comp),
      .write(write),
      .valid_in(valid_in),

      .tag_out(c1_tag_out),
      .data_out(c1_data_out),
      .hit(c1_hit),
      .dirty(d1),
      .valid(v1),
      .err(c1_err)
   );

   assign err = (c0_err | c1_err) & enable;
   assign hit = c0_hit | c1_hit;
   assign valid = (c0_hit & v0) | (c1_hit & v1);
   assign dirty = A_now ? d1 : d0;
   
   assign tag_out = A ? c1_tag_out : c0_tag_out;
   assign comp_data_out = (c0_data_out & {16{c0_hit & v0}}) | (c1_data_out & {16{c1_hit & v1}});
   
   assign data_out = comp ? comp_data_out : (A ? c1_data_out : c0_data_out);
   
   
endmodule
