module ALU(
    iClk,
    nRst,
    iOP,
    iA,
    iB,
    oC
);

input wire iClk, nRst;
input wire [3:0] iOP;
input wire [31:0] iA, iB;
output wire [31:0] oC;

wire [31:0] r_add, r_sub, r_xor, r_or, r_and, r_sll, r_srl, r_sra, r_slt, r_sltu;

assign r_add = iA + iB;
assign r_sub = iA - iB;
assign r_xor = iA ^ iB;
assign r_or = iA | iB;
assign r_and = iA & iB;
assign r_sll = iA << iB[4:0];
assign r_srl = iA >> iB[4:0];
assign r_sra = iA >>> iB[4:0];
assign r_slt = (iA < iB) ? 32'd1 : 32'd0;
assign r_sltu = (iA < iB) ? 32'd1 : 32'd0;

assign oC = (iOP == 4'h0) ? r_add  :
            (iOP == 4'h1) ? r_sub  :
            (iOP == 4'h2) ? r_xor  :
            (iOP == 4'h3) ? r_or   :
            (iOP == 4'h4) ? r_and  :
            (iOP == 4'h5) ? r_sll  :
            (iOP == 4'h6) ? r_srl  :
            (iOP == 4'h5) ? r_sra  :
            (iOP == 4'h2) ? r_slt  :
            (iOP == 4'h9) ? r_sltu : 32'd0;


endmodule