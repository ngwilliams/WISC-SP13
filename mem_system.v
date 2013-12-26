/* $Author: karu $ */
/* $LastChangedDate: 2009-04-24 09:28:13 -0500 (Fri, 24 Apr 2009) $ */
/* $Rev: 77 $ */

module mem_system(/*AUTOARG*/
   // Outputs
   DataOut, Done, Stall, CacheHit, err, 
   // Inputs
   Addr, DataIn, Rd, Wr, createdump, clk, rst,valid
   );
   
   input [15:0] Addr;
   input [15:0] DataIn;
   input        Rd;
   input        Wr;
   input        createdump;
   input        clk;
   input        rst;
   
   output [15:0] DataOut;
   output Done;
   output Stall;
   output CacheHit;
   output err;
   output valid;

   /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
   parameter mem_type = 0;
   
   
   wire          cache_ctrl_over;
   wire   [1:0]  cache_offset;
   wire   [4:0]  cache_tag_out;
   wire          cache_err;
   wire          cache_wr;
   wire          hit;
   wire          valid;
   wire          dirty;
   wire          comp;
   
   wire   [1:0]  mem_offset;
   wire          mem_addr_sel;
   wire   [15:0] mem_data_out;
   wire          mem_stall;
   wire   [3:0]  mem_busy;
   wire          mem_rd;
   wire          mem_wr;
   wire          mem_err;
   
   four_bank_mem m0(
      .clk(clk),
      .rst(rst),
      .createdump(createdump),
      .addr(mem_addr_sel ? 
            {Addr[15:3], mem_offset, 1'b0}
          : {cache_tag_out, Addr[10:3], mem_offset, 1'b0} ),
      .data_in(DataOut),
      .wr(mem_wr),
      .rd(mem_rd),               
      .data_out(mem_data_out),
      .stall(mem_stall),
      .busy(mem_busy),
      .err(mem_err)
   );
   
   cache_2way #(0 + mem_type) c0(
      .enable(Wr | Rd),
      .clk(clk),
      .rst(rst),
      .createdump(createdump),
      .tag_in(Addr[15:11]),
      .index(Addr[10:3]),
      .offset(cache_ctrl_over ? {cache_offset, 1'b0} : Addr[2:0]),
      .data_in(cache_ctrl_over ? mem_data_out : DataIn),
      .comp(comp),
      .write(cache_ctrl_over ? cache_wr : Wr),
      .valid_in(1'b1),

      .tag_out(cache_tag_out),
      .data_out(DataOut),
      .hit(hit),
      .dirty(dirty),
      .valid(valid),
      .err(cache_err)
   );
   
   mem_system_ctrl ctrl0(
      .clk(clk),
      .rst(rst),
      .wr(Wr),
      .rd(Rd),
      .hit(hit & valid),
      .dirty(dirty),
      .cache_ctrl_over(cache_ctrl_over),
      .cache_offset(cache_offset),
      .comp(comp),
      .cache_wr(cache_wr),
      .mem_addr_sel(mem_addr_sel),
      .mem_offset(mem_offset),
      .stall(Stall),
      .mem_wr(mem_wr),
      .mem_rd(mem_rd),
      .done(Done),
      .cache_hit(CacheHit),
      .err(ctrl_err)
   );
   
   assign err = cache_err | mem_err | ctrl_err | mem_stall;
   
endmodule // mem_system

   


// DUMMY LINE FOR REV CONTROL :9:
