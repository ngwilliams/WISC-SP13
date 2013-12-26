module dffe (q, d, en, clk, rst);
    
    
    input d;
    input en;
    input clk;
    input rst;
    
    output q;
    
    wire  de;
    
    assign de = en ? d : q;
    
    dff flop(
        .q(q),
        .d(de),
        .clk(clk),
        .rst(rst)
    );
    
endmodule
