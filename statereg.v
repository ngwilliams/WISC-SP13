module statereg (clk,rst,next_state,state);

   input         clk;
   input         rst;
   input   [3:0] next_state;

   output  [3:0] state;

   dff state_flops[3:0] (.d  (next_state),
                         .q  (state),
                         .clk(clk),
                         .rst(rst)
   );

endmodule

