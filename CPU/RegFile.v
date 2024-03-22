module RegFile(
    iClk, nRst, iWrite,
    iAddrA, iAddrB, iAddrC,
    oRegA, oRegB, iRegC
);

// Module IO
input wire iClk, nRst, iWrite;
input wire [4:0] iAddrA, iAddrB, iAddrC;
output wire [31:0] oRegA, oRegB;
input wire [31:0] iRegC;

// Register IO
wire r1_write, r2_write, r3_write, r5_write, r6_write, r7_write, r8_write, r9_write, r10_write;
wire [31:0] r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out, r10_out;

// Write Signal Assert
assign r1_write = (iAddrC == 5'b00001) && iWrite;
assign r2_write = (iAddrC == 5'b00010) && iWrite;
assign r3_write = (iAddrC == 5'b00011) && iWrite;
assign r4_write = (iAddrC == 5'b00100) && iWrite;
assign r5_write = (iAddrC == 5'b00101) && iWrite;
assign r6_write = (iAddrC == 5'b00110) && iWrite;
assign r7_write = (iAddrC == 5'b00111) && iWrite;
assign r8_write = (iAddrC == 5'b01000) && iWrite;
assign r9_write = (iAddrC == 5'b01001) && iWrite;
assign r10_write = (iAddrC == 5'b01010) && iWrite;


// Output Register A assignment
assign oRegA =  (iAddrA == 5'b00001) ? r1_out :
                (iAddrA == 5'b00010) ? r2_out :
                (iAddrA == 5'b00011) ? r3_out :
                (iAddrA == 5'b00100) ? r4_out :
                (iAddrA == 5'b00101) ? r5_out :
                (iAddrA == 5'b00110) ? r6_out :
                (iAddrA == 5'b00111) ? r7_out :
                (iAddrA == 5'b01000) ? r8_out :
                (iAddrA == 5'b01001) ? r9_out :
                (iAddrA == 5'b01010) ? r10_out :
                32'd0;

// Output Register A assignment
assign oRegB =  (iAddrB == 5'b00001) ? r1_out :
                (iAddrB == 5'b00010) ? r2_out :
                (iAddrB == 5'b00011) ? r3_out :
                (iAddrB == 5'b00100) ? r4_out :
                (iAddrB == 5'b00101) ? r5_out :
                (iAddrB == 5'b00110) ? r6_out :
                (iAddrB == 5'b00111) ? r7_out :
                (iAddrB == 5'b01000) ? r8_out :
                (iAddrB == 5'b01001) ? r9_out :
                (iAddrB == 5'b01010) ? r10_out :
                32'd0;

// Registers
REG32 r1( .iClk(iClk), .nRst(nRst), .iEn(r1_write), .iD(iRegC), .oQ(r1_out) );
REG32 r2( .iClk(iClk), .nRst(nRst), .iEn(r2_write), .iD(iRegC), .oQ(r2_out) );
REG32 r3( .iClk(iClk), .nRst(nRst), .iEn(r3_write), .iD(iRegC), .oQ(r3_out) );
REG32 r4( .iClk(iClk), .nRst(nRst), .iEn(r4_write), .iD(iRegC), .oQ(r4_out) );
REG32 r5( .iClk(iClk), .nRst(nRst), .iEn(r5_write), .iD(iRegC), .oQ(r5_out) );
REG32 r6( .iClk(iClk), .nRst(nRst), .iEn(r6_write), .iD(iRegC), .oQ(r6_out) );
REG32 r7( .iClk(iClk), .nRst(nRst), .iEn(r7_write), .iD(iRegC), .oQ(r7_out) );
REG32 r8( .iClk(iClk), .nRst(nRst), .iEn(r8_write), .iD(iRegC), .oQ(r8_out) );
REG32 r9( .iClk(iClk), .nRst(nRst), .iEn(r9_write), .iD(iRegC), .oQ(r9_out) );
REG32 r10( .iClk(iClk), .nRst(nRst), .iEn(r10_write), .iD(iRegC), .oQ(r10_out) );

endmodule
