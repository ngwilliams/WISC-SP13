module statelogic(wr,rd,hit,dirty,state,
                  next_state,cache_ctrl_over,cache_offset,comp,done,cache_hit,
                  cache_wr,mem_addr_sel,mem_offset,stall,mem_wr,mem_rd,err);

   input         wr;
   input         rd;
   input         hit;
   input         dirty;
   input   [3:0] state;

   output reg [3:0] next_state;
   output        cache_ctrl_over;
   output  [1:0] cache_offset;
   output        comp;
   output        cache_wr;
   output        mem_addr_sel;
   output  [1:0] mem_offset;
   output        stall;
   output        mem_wr;
   output        mem_rd;
   output        done;
   output        cache_hit;
   output reg    err;
   

   always @(state,wr,rd,hit,dirty)
      begin
         err = 1'b0;
         casex({state,wr,rd,hit,dirty})

            // state0 & [~(wr|rd) | hit]
            8'b0000_0_0_?_?:
               next_state <= 4'b0000;
            8'b0000_?_?_1_?:
               next_state <= 4'b0000;
            
            // state0 & [(wr|rd) & ~hit & dirty]
            8'b0000_1_?_0_1:
               next_state <= 4'b0001;
            8'b0000_?_1_0_1:
               next_state <= 4'b0001;

            // state0 & [(wr|rd) & ~hit & ~dirty]
            8'b0000_1_?_0_0:
               next_state <= 4'b0101;
            8'b0000_?_1_0_0:
               next_state <= 4'b0101;

            // state1
            8'b0001_?_?_?_?:
               next_state <= 4'b0010;

            // state2
            8'b0010_?_?_?_?:
               next_state <= 4'b0011;

            // state3
            8'b0011_?_?_?_?:
               next_state <= 4'b0100;

            // state4
            8'b0100_?_?_?_?:
               next_state <= 4'b0101;

            // state5
            8'b0101_?_?_?_?:
               next_state <= 4'b0110;

            // state6
            8'b0110_?_?_?_?:
               next_state <= 4'b0111;

            // state7
            8'b0111_?_?_?_?:
               next_state <= 4'b1000;

            // state8
            8'b1000_?_?_?_?:
               next_state <= 4'b1001;

            // state9
            8'b1001_?_?_?_?:
               next_state <= 4'b1010;

            // state10
            8'b1010_?_?_?_?:
               next_state <= 4'b1011;

	    // state 11
	    8'b1011_?_?_?_?:
               next_state <= 4'b1100;
	   
            // state12 & [~(wr|rd) | hit]
            8'b1100_0_0_?_?:
               next_state <= 4'b0000;
            8'b1100_?_?_1_?:
               next_state <= 4'b0000;
            
            // state12 & [(wr|rd) & ~hit & dirty]
            8'b1100_1_?_0_1:
               next_state <= 4'b0001;
            8'b1100_?_1_0_1:
               next_state <= 4'b0001;

            // state12 & [(wr|rd) & ~hit & ~dirty]
            8'b1100_1_?_0_0:
               next_state <= 4'b0101;
            8'b1100_?_1_0_0:
               next_state <= 4'b0101;

            default: begin
               next_state <= 4'b1111;
               err = 1'b1;
            end
         endcase
      end

   assign cache_ctrl_over = (state == 4'h1)|(state == 4'h2)|
                            (state == 4'h3)|(state == 4'h4)| 
                            (state == 4'h7)|(state == 4'h8)| 
                            (state == 4'h9)|(state == 4'hA);
   assign cache_offset[1] = (state == 4'h3)|(state == 4'h4)| 
                            (state == 4'h9)|(state == 4'hA);
   assign cache_offset[0] = (state == 4'h2)|(state == 4'h4)|
                            (state == 4'h8)|(state == 4'hA);
   assign comp            = (state == 4'h0)|(state == 4'hB)|
                            (state == 4'hC);
   assign cache_wr        = (state != 4'h1)&(state != 4'h2)&
                            (state != 4'h3)&(state != 4'h4);
   assign mem_addr_sel    = (state == 4'h5)|(state == 4'h6)|
                            (state == 4'h7)|(state == 4'h8);
   assign mem_offset[1]   = (state == 4'h3)|(state == 4'h4)|
                            (state == 4'h7)|(state == 4'h8);
   assign mem_offset[0]   = (state == 4'h2)|(state == 4'h4)|
                            (state == 4'h6)|(state == 4'h8);
   assign stall           = (state != 4'h0)&(state != 4'hC);
   assign mem_wr          = (state == 4'h1)|(state == 4'h2)|
                            (state == 4'h3)|(state == 4'h4);
   assign mem_rd          = (state == 4'h5)|(state == 4'h6)|
                            (state == 4'h7)|(state == 4'h8); 
   assign done            = ((state == 4'h0)&hit)
                              |(state == 4'hC);
   assign cache_hit       = ((state == 4'h0)&hit);
                  

endmodule
