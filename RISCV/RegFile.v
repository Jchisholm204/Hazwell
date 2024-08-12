module RegFile(
    iClk, nRst, iWrite,
    iAddrA, iAddrB, iAddrC,
    oRegA, oRegB, iRegC
);

input wire iClk, nRst, iWrite;
input wire [4:0] iAddrA, iAddrB, iAddrC;
output wire [31:0] oRegA, oRegB;
input wire [31:0] iRegC;

wire r1_write,
     r2_write, 
     r3_write, 
     r4_write, 
     r5_write, 
     r6_write, 
     r7_write, 
     r8_write, 
     r9_write, 
     r10_write, 
     r11_write, 
     r12_write, 
     r13_write, 
     r14_write, 
     r15_write, 
     r16_write, 
     r17_write, 
     r18_write, 
     r19_write, 
     r20_write, 
     r21_write, 
     r22_write, 
     r23_write, 
     r24_write, 
     r25_write, 
     r26_write, 
     r27_write, 
     r28_write, 
     r29_write, 
     r30_write, 
     r31_write;

wire r0_out,
     r1_out,
     r2_out, 
     r3_out, 
     r4_out, 
     r5_out, 
     r6_out, 
     r7_out, 
     r8_out, 
     r9_out, 
     r10_out, 
     r11_out, 
     r12_out, 
     r13_out, 
     r14_out, 
     r15_out, 
     r16_out, 
     r17_out, 
     r18_out, 
     r19_out, 
     r20_out, 
     r21_out, 
     r22_out, 
     r23_out, 
     r24_out, 
     r25_out, 
     r26_out, 
     r27_out, 
     r28_out, 
     r29_out, 
     r30_out, 
     r31_out;

assign r1_write = (iWrite && iAddrC == 5'b00001);
assign r2_write = (iWrite && iAddrC == 5'b00010);
assign r3_write = (iWrite && iAddrC == 5'b00011);
assign r4_write = (iWrite && iAddrC == 5'b00100);
assign r5_write = (iWrite && iAddrC == 5'b00101);
assign r6_write = (iWrite && iAddrC == 5'b00110);
assign r7_write = (iWrite && iAddrC == 5'b00111);
assign r8_write = (iWrite && iAddrC == 5'b01000);
assign r9_write = (iWrite && iAddrC == 5'b01001);
assign r10_write = (iWrite && iAddrC == 5'b01010);
assign r11_write = (iWrite && iAddrC == 5'b01011);
assign r12_write = (iWrite && iAddrC == 5'b01100);
assign r13_write = (iWrite && iAddrC == 5'b01101);
assign r14_write = (iWrite && iAddrC == 5'b01110);
assign r15_write = (iWrite && iAddrC == 5'b01111);
assign r16_write = (iWrite && iAddrC == 5'b10000);
assign r17_write = (iWrite && iAddrC == 5'b10001);
assign r18_write = (iWrite && iAddrC == 5'b10010);
assign r19_write = (iWrite && iAddrC == 5'b10011);
assign r20_write = (iWrite && iAddrC == 5'b10100);
assign r21_write = (iWrite && iAddrC == 5'b10101);
assign r22_write = (iWrite && iAddrC == 5'b10110);
assign r23_write = (iWrite && iAddrC == 5'b10111);
assign r24_write = (iWrite && iAddrC == 5'b11000);
assign r25_write = (iWrite && iAddrC == 5'b11001);
assign r26_write = (iWrite && iAddrC == 5'b11010);
assign r27_write = (iWrite && iAddrC == 5'b11011);
assign r28_write = (iWrite && iAddrC == 5'b11100);
assign r29_write = (iWrite && iAddrC == 5'b11101);
assign r30_write = (iWrite && iAddrC == 5'b11110);
assign r31_write = (iWrite && iAddrC == 5'b11111);

assign r0_out = 32'b0;
REG32 r1 ( .iClk(iClk), .nRst(nRst), .iEn(r1_write), .iD(iRegC), .oQ(r1_out) );
REG32 r2 ( .iClk(iClk), .nRst(nRst), .iEn(r2_write), .iD(iRegC), .oQ(r2_out) );
REG32 r3 ( .iClk(iClk), .nRst(nRst), .iEn(r3_write), .iD(iRegC), .oQ(r3_out) );
REG32 r4 ( .iClk(iClk), .nRst(nRst), .iEn(r4_write), .iD(iRegC), .oQ(r4_out) );
REG32 r5 ( .iClk(iClk), .nRst(nRst), .iEn(r5_write), .iD(iRegC), .oQ(r5_out) );
REG32 r6 ( .iClk(iClk), .nRst(nRst), .iEn(r6_write), .iD(iRegC), .oQ(r6_out) );
REG32 r7 ( .iClk(iClk), .nRst(nRst), .iEn(r7_write), .iD(iRegC), .oQ(r7_out) );
REG32 r8 ( .iClk(iClk), .nRst(nRst), .iEn(r8_write), .iD(iRegC), .oQ(r8_out) );
REG32 r9 ( .iClk(iClk), .nRst(nRst), .iEn(r9_write), .iD(iRegC), .oQ(r9_out) );
REG32 r10 ( .iClk(iClk), .nRst(nRst), .iEn(r10_write), .iD(iRegC), .oQ(r10_out) );
REG32 r11 ( .iClk(iClk), .nRst(nRst), .iEn(r11_write), .iD(iRegC), .oQ(r11_out) );
REG32 r12 ( .iClk(iClk), .nRst(nRst), .iEn(r12_write), .iD(iRegC), .oQ(r12_out) );
REG32 r13 ( .iClk(iClk), .nRst(nRst), .iEn(r13_write), .iD(iRegC), .oQ(r13_out) );
REG32 r14 ( .iClk(iClk), .nRst(nRst), .iEn(r14_write), .iD(iRegC), .oQ(r14_out) );
REG32 r15 ( .iClk(iClk), .nRst(nRst), .iEn(r15_write), .iD(iRegC), .oQ(r15_out) );
REG32 r16 ( .iClk(iClk), .nRst(nRst), .iEn(r16_write), .iD(iRegC), .oQ(r16_out) );
REG32 r17 ( .iClk(iClk), .nRst(nRst), .iEn(r17_write), .iD(iRegC), .oQ(r17_out) );
REG32 r18 ( .iClk(iClk), .nRst(nRst), .iEn(r18_write), .iD(iRegC), .oQ(r18_out) );
REG32 r19 ( .iClk(iClk), .nRst(nRst), .iEn(r19_write), .iD(iRegC), .oQ(r19_out) );
REG32 r20 ( .iClk(iClk), .nRst(nRst), .iEn(r20_write), .iD(iRegC), .oQ(r20_out) );
REG32 r21 ( .iClk(iClk), .nRst(nRst), .iEn(r21_write), .iD(iRegC), .oQ(r21_out) );
REG32 r22 ( .iClk(iClk), .nRst(nRst), .iEn(r22_write), .iD(iRegC), .oQ(r22_out) );
REG32 r23 ( .iClk(iClk), .nRst(nRst), .iEn(r23_write), .iD(iRegC), .oQ(r23_out) );
REG32 r24 ( .iClk(iClk), .nRst(nRst), .iEn(r24_write), .iD(iRegC), .oQ(r24_out) );
REG32 r25 ( .iClk(iClk), .nRst(nRst), .iEn(r25_write), .iD(iRegC), .oQ(r25_out) );
REG32 r26 ( .iClk(iClk), .nRst(nRst), .iEn(r26_write), .iD(iRegC), .oQ(r26_out) );
REG32 r27 ( .iClk(iClk), .nRst(nRst), .iEn(r27_write), .iD(iRegC), .oQ(r27_out) );
REG32 r28 ( .iClk(iClk), .nRst(nRst), .iEn(r28_write), .iD(iRegC), .oQ(r28_out) );
REG32 r29 ( .iClk(iClk), .nRst(nRst), .iEn(r29_write), .iD(iRegC), .oQ(r29_out) );
REG32 r30 ( .iClk(iClk), .nRst(nRst), .iEn(r30_write), .iD(iRegC), .oQ(r30_out) );
REG32 r31 ( .iClk(iClk), .nRst(nRst), .iEn(r31_write), .iD(iRegC), .oQ(r31_out) );


assign oRegA =  (iAddrA == 5'b00000) ? r0_out :
                (iAddrA == 5'b00001) ? r1_out :
                (iAddrA == 5'b00010) ? r2_out :
                (iAddrA == 5'b00011) ? r3_out :
                (iAddrA == 5'b00100) ? r4_out :
                (iAddrA == 5'b00101) ? r5_out :
                (iAddrA == 5'b00110) ? r6_out :
                (iAddrA == 5'b00111) ? r7_out :
                (iAddrA == 5'b01000) ? r8_out :
                (iAddrA == 5'b01001) ? r9_out :
                (iAddrA == 5'b01010) ? r10_out :
                (iAddrA == 5'b01011) ? r11_out :
                (iAddrA == 5'b01100) ? r12_out :
                (iAddrA == 5'b01101) ? r13_out :
                (iAddrA == 5'b01110) ? r14_out :
                (iAddrA == 5'b01111) ? r15_out :
                (iAddrA == 5'b10000) ? r16_out :
                (iAddrA == 5'b10001) ? r17_out :
                (iAddrA == 5'b10010) ? r18_out :
                (iAddrA == 5'b10011) ? r19_out :
                (iAddrA == 5'b10100) ? r20_out :
                (iAddrA == 5'b10101) ? r21_out :
                (iAddrA == 5'b10110) ? r22_out :
                (iAddrA == 5'b10111) ? r23_out :
                (iAddrA == 5'b11000) ? r24_out :
                (iAddrA == 5'b11001) ? r25_out :
                (iAddrA == 5'b11010) ? r26_out :
                (iAddrA == 5'b11011) ? r27_out :
                (iAddrA == 5'b11100) ? r28_out :
                (iAddrA == 5'b11101) ? r29_out :
                (iAddrA == 5'b11110) ? r30_out :
                (iAddrA == 5'b11111) ? r31_out : r0_out;

assign oRegB =  (iAddrB == 5'b00000) ? r0_out :
                (iAddrB == 5'b00001) ? r1_out :
                (iAddrB == 5'b00010) ? r2_out :
                (iAddrB == 5'b00011) ? r3_out :
                (iAddrB == 5'b00100) ? r4_out :
                (iAddrB == 5'b00101) ? r5_out :
                (iAddrB == 5'b00110) ? r6_out :
                (iAddrB == 5'b00111) ? r7_out :
                (iAddrB == 5'b01000) ? r8_out :
                (iAddrB == 5'b01001) ? r9_out :
                (iAddrB == 5'b01010) ? r10_out :
                (iAddrB == 5'b01011) ? r11_out :
                (iAddrB == 5'b01100) ? r12_out :
                (iAddrB == 5'b01101) ? r13_out :
                (iAddrB == 5'b01110) ? r14_out :
                (iAddrB == 5'b01111) ? r15_out :
                (iAddrB == 5'b10000) ? r16_out :
                (iAddrB == 5'b10001) ? r17_out :
                (iAddrB == 5'b10010) ? r18_out :
                (iAddrB == 5'b10011) ? r19_out :
                (iAddrB == 5'b10100) ? r20_out :
                (iAddrB == 5'b10101) ? r21_out :
                (iAddrB == 5'b10110) ? r22_out :
                (iAddrB == 5'b10111) ? r23_out :
                (iAddrB == 5'b11000) ? r24_out :
                (iAddrB == 5'b11001) ? r25_out :
                (iAddrB == 5'b11010) ? r26_out :
                (iAddrB == 5'b11011) ? r27_out :
                (iAddrB == 5'b11100) ? r28_out :
                (iAddrB == 5'b11101) ? r29_out :
                (iAddrB == 5'b11110) ? r30_out :
                (iAddrB == 5'b11111) ? r31_out : r0_out;

endmodule