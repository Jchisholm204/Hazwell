module ALU(
    OP, oZero, oNeg,
    iRA, iRB, oRC
);

input wire [5:0] OP;
output wire oZero, oNeg;
input wire [31:0] iRA, iRB;
output wire [31:0] oRC;

endmodule
