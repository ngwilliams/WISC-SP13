module SignExtend11_16 (in, out);

input[10:0] in;
output[15:0] out;

assign out = {{5{in[10]}},in[10:0]};

endmodule
