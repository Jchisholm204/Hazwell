module ALU(
    iOP,
    iRegA, iRegB,
    oRegC
)

input wire [3:0] iOP;
input wire [31:0] iRegA, iRegB;
output reg [31:0] oRegC;


