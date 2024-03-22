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

assign oRegC =  (iOP == 4'b0000) ? iRegA  +   iRegB  : // Addition
                (iOP == 4'b0001) ? iRegA  -   iRegB  : // Subtraction
                (iOP == 4'b0010) ? iRegA  *   iRegB  : // Multiplication
                (iOP == 4'b0011) ? iRegA  <<  iRegB  : // Shift Left
                (iOP == 4'b0100) ? iRegA  <<< iRegB  : // Shift Left  Arithmatic
                (iOP == 4'b0101) ? iRegA  >>  iRegB  : // Shift Right
                (iOP == 4'b0111) ? iRegA  >>> iRegB  : // Shift Right Arithmatic
                (iOP == 4'b1000) ? (iRegA >=  iRegB) : // Compare Greater than or equal
                (iOP == 4'b1000) ? (iRegA >   iRegB) : // Compare Greater than
                iRegA + iRegB;

assign oNEG = oRegC[31];
assign oZERO = (oRegC == 32'd0);

endmodule
