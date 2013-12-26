module BranchForwardingUnit( RegWrite_EM,RegWrite_MW, Rd_EM,Rd_MW,Rs_FD,forward);

input wire [2:0] Rd_EM,Rd_MW,Rs_FD;
input wire RegWrite_EM,RegWrite_MW;
output wire [1:0] forward;

// internal wires
wire RsMatchEM;
wire RsMatchMW;

assign RsMatchEM = ((RegWrite_EM) & (Rd_EM == Rs_FD)) ? 1 : 0;
assign RsMatchMW = ((RegWrite_MW) & (Rd_MW == Rs_FD)) ? 1 : 0;

assign forward  = (RsMatchEM) ? 2'b10 : (RsMatchMW) ? 2'b01 : 2'b00;

endmodule
