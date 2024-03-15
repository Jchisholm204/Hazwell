module RegFile(
    .iClk, nRst, iWrite,
    iAddrA, iAddrB, iAddrC,
    oRegA, oRegB, iRegC,
);

// Module IO
input wire iClk, nRst, iWrite;
input wire [4:0] iAddrA, iAddrB, iAddrC;
output wire [31:0] oRegA, oRegB;
input wire [31:0] iRegC;

// Register IO
reg r1_write, r2_write, r3_write;
wire [31:0] r1_out, r2_out, r3_out;

// Write Signal Assert
assign r1_write = (iAddrC == 5'b00001) and iWrite;
assign r2_write = (iAddrC == 5'b00010) and iWrite;
assign r3_write = (iAddrC == 5'b00011) and iWrite;

// Output Register A assignment
assign oRegA =  (iAddrA == 5'b00001) ? r1_out :
                (iAddrA == 5'b00010) ? r2_out :
                (iAddrA == 5'b00011) ? r3_out :
                32'd0;

// Output Register A assignment
assign oRegB =  (iAddrB == 5'b00001) ? r1_out :
                (iAddrB == 5'b00010) ? r2_out :
                (iAddrB == 5'b00011) ? r3_out :
                32'd0;

// Registers
REG32 r1( .iClk(iClk), .nRst(nRst), .iEn(r1_write), .iD(iRegC), .oQ(r1_out) );
REG32 r2( .iClk(iClk), .nRst(nRst), .iEn(r2_write), .iD(iRegC), .oQ(r2_out) );
REG32 r3( .iClk(iClk), .nRst(nRst), .iEn(r3_write), .iD(iRegC), .oQ(r3_out) );
