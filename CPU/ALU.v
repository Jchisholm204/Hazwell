module ALU(
    iOP,
    iRegA, iRegB,
    oRegC,
    oNEG, oZERO
);

input  wire [3:0]  iOP;
input  wire [31:0] iRegA, iRegB;
output wire [31:0] oRegC;
output wire        oNEG, oZERO;

assign oRegC =  (iOP == 4'h1) ? iRegA + iRegB : // Addition
                (iOP == 4'h2) ? iRegA - iRegB : // Subtraction
                32'd0;

assign oNEG = oRegC[31];
assign oZERO = (oRegC == 32'd0);

endmodule
