module SignExtend8_16 (in, out);

input[7:0] in;
output[15:0] out;

assign out = {{8{in[7]}},in[7:0]};

endmodule
