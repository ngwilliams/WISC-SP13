module ShiftLeftOne11_12 (in, out);

input[10:0] in;
output[11:0] out;

assign out = {in[10:0], 1'b0};

endmodule
