module	DataForwardingUnit( RegWrite_EM, Rd_EM, Rs_DE, Rt_DE, forwardA,forwardB, RegWrite_MW, Rd_MW, Rs_EM, RsV_EM, Rs_MW, RsV_MW, ReadMem_EM,RsV_DE,RdV_EM,RtV_DE, RdV_MW);
input wire [2:0] Rd_EM, Rs_DE, Rt_DE, Rd_MW, Rs_EM, Rs_MW;
input wire RegWrite_EM, RegWrite_MW, ReadMem_EM, RsV_EM, RsV_MW,RsV_DE,RdV_EM,RtV_DE, RdV_MW;
output wire [1:0] forwardA,forwardB;

// internal wires
wire RsMatchEM, RtMatchEM, RsMatchMW,RtMatchMW;

assign RsMatchEM = (RegWrite_EM & (Rs_DE==Rd_EM) & RsV_DE & RdV_EM) ? 1 : 0;
assign RtMatchEM = (RegWrite_EM & (Rt_DE==Rd_EM) & RtV_DE & RdV_EM) ? 1 : 0;
assign RsMatchMW = (RegWrite_MW & (Rs_DE==Rd_MW) & RsV_DE & RdV_MW) ? 1 : 0;
assign RtMatchMW = (RegWrite_MW & (Rt_DE==Rd_MW) & RtV_DE & RdV_MW) ? 1 : 0;

assign LoadEM = (ReadMem_EM & RegWrite_EM & RsV_EM & (Rs_DE==Rs_EM)) ? 1 : 0;

assign forwardA = (LoadEM)? 2'b11 : (RsMatchEM) ? 2'b10 : (RsMatchMW) ? 2'b01 : 2'b00;//special load case, forwardA=11
assign forwardB = (RtMatchEM) ? 2'b10 : (RtMatchMW) ? 2'b01 : 2'b00;


endmodule
