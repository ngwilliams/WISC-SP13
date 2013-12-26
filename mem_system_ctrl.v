module mem_system_ctrl(clk,rst,wr,rd,hit,
                       cache_ctrl_over,cache_offset,comp,cache_wr,done,cache_hit,
                       mem_addr_sel,mem_offset,stall,err,dirty,mem_wr,mem_rd);

   input         clk;
   input         rst;
   input         wr;
   input         rd;
   input         hit;
   input         dirty;

   output        cache_ctrl_over;
   output  [1:0] cache_offset;
   output        comp;
   output        cache_wr;
   output        mem_addr_sel;
   output  [1:0] mem_offset;
   output        stall;
   output        mem_rd;
   output        mem_wr;
   output        err;
   output        done;
   output        cache_hit;

   wire    [3:0] state;
   wire    [3:0] next_state;

   statereg   state_reg(.state          (state),
                        .next_state     (next_state),
                        .clk            (clk),
                        .rst            (rst)
   );

   statelogic state_log(.wr             (wr),
                        .rd             (rd),
                        .hit            (hit),
                        .dirty          (dirty),
                        .state          (state),
                        .next_state     (next_state),
                        .cache_ctrl_over(cache_ctrl_over),
                        .cache_offset   (cache_offset),
                        .comp           (comp),
                        .cache_wr       (cache_wr),
                        .mem_addr_sel   (mem_addr_sel),
                        .mem_offset     (mem_offset),
                        .stall          (stall),
                        .mem_wr         (mem_wr),
                        .mem_rd         (mem_rd),
			.done           (done),
			.cache_hit      (cache_hit),
                        .err            (err)
   );

endmodule
