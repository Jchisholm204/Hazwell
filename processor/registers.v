module registers(
    iClk, nRst, iWrite,
    iAddrA, iAddrB, iAddrC,
    oRegA, oRegB, iRegC
);

// Module IO
input wire iClk, nRst, iWrite;
input wire [4:0] iAddrA, iAddrB, iAddrC;
output wire [31:0] oRegA, oRegB;
input wire [31:0] iRegC;

parameter [5:0] R0       = 5'b00000,
                R1       = 5'b00001,
                R2       = 5'b00010,
                R3       = 5'b00011,
                R4       = 5'b00100,
                R5       = 5'b00101,
                R6       = 5'b00110,
                R7       = 5'b00111,
                R8       = 5'b01000,
                R9       = 5'b01001,
                R10      = 5'b01010,
                R11      = 5'b01011,
                R12      = 5'b01100,
                R13      = 5'b01101,
                R14      = 5'b01110,
                R15      = 5'b01111,
                R16      = 5'b10000,
                R17      = 5'b10001,
                R18      = 5'b10010,
                R19      = 5'b10011,
                R20      = 5'b10100,
                R21      = 5'b10101,
                R22      = 5'b10110,
                R23      = 5'b10111,
                Ret      = 5'b11000,
                Rbt      = 5'b11001,
                Rgp      = 5'b11010,
                Rsp      = 5'b11011,
                Rfp      = 5'b11100,
                Rea      = 5'b11101,
                Rsstatus = 5'b11110,
                Rra      = 5'b11111;

// Register IO
wire r1_write, r2_write, r3_write, r5_write, r6_write,
     r7_write, r8_write, r9_write, r10_write, r11_write,
     r12_write, r13_write, r14_write, r15_write, r16_write,
     r17_write, r18_write, r19_write, r20_write, r21_write,
     r22_write, r23_write, r24_write, r25_write, r26_write,
     r27_write, r28_write, r29_write, r30_write, r31_write;

wire [31:0] r1_out, r2_out, r3_out, r4_out, r5_out,
            r6_out, r7_out, r8_out, r9_out, r10_out,
            r11_out, r12_out, r13_out, r14_out, r15_out,
            r16_out, r17_out, r18_out, r19_out, r20_out,
            r21_out, r22_out, r23_out, r24_out, r25_out,
            r26_out, r27_out, r28_out, r29_out, r30_out, r31_out;

// Write Signal Assert
assign r1_write  = (iAddrC == R1) && iWrite;
assign r2_write  = (iAddrC == R2) && iWrite;
assign r3_write  = (iAddrC == R3) && iWrite;
assign r4_write  = (iAddrC == R4) && iWrite;
assign r5_write  = (iAddrC == R5) && iWrite;
assign r6_write  = (iAddrC == R6) && iWrite;
assign r7_write  = (iAddrC == R7) && iWrite;
assign r8_write  = (iAddrC == R8) && iWrite;
assign r9_write  = (iAddrC == R9) && iWrite;
assign r10_write = (iAddrC == R10) && iWrite;
assign r11_write = (iAddrC == R11) && iWrite;
assign r12_write = (iAddrC == R12) && iWrite;
assign r13_write = (iAddrC == R13) && iWrite;
assign r14_write = (iAddrC == R14) && iWrite;
assign r15_write = (iAddrC == R15) && iWrite;
assign r16_write = (iAddrC == R16) && iWrite;
assign r17_write = (iAddrC == R17) && iWrite;
assign r18_write = (iAddrC == R18) && iWrite;
assign r19_write = (iAddrC == R19) && iWrite;
assign r20_write = (iAddrC == R20) && iWrite;
assign r21_write = (iAddrC == R21) && iWrite;
assign r22_write = (iAddrC == R22) && iWrite;
assign r23_write = (iAddrC == R23) && iWrite;
assign r24_write = (iAddrC == Ret) && iWrite;
assign r25_write = (iAddrC == Rbt) && iWrite;
assign r26_write = (iAddrC == Rgp) && iWrite;
assign r27_write = (iAddrC == Rsp) && iWrite;
assign r28_write = (iAddrC == Rfp) && iWrite;
assign r29_write = (iAddrC == Rea) && iWrite;
assign r30_write = (iAddrC == Rsstatus) && iWrite;
assign r31_write = (iAddrC == Rra) && iWrite;


// Output Register A assignment
assign oRegA =  (iAddrA == R1)       ? r1_out  :
                (iAddrA == R2)       ? r2_out  :
                (iAddrA == R3)       ? r3_out  :
                (iAddrA == R4)       ? r4_out  :
                (iAddrA == R5)       ? r5_out  :
                (iAddrA == R6)       ? r6_out  :
                (iAddrA == R7)       ? r7_out  :
                (iAddrA == R8)       ? r8_out  :
                (iAddrA == R9)       ? r9_out  :
                (iAddrA == R10)      ? r10_out :
                (iAddrA == R11)      ? r11_out :
                (iAddrA == R12)      ? r12_out :
                (iAddrA == R13)      ? r13_out :
                (iAddrA == R14)      ? r14_out :
                (iAddrA == R15)      ? r15_out :
                (iAddrA == R16)      ? r16_out :
                (iAddrA == R17)      ? r17_out :
                (iAddrA == R18)      ? r18_out :
                (iAddrA == R19)      ? r19_out :
                (iAddrA == R20)      ? r20_out :
                (iAddrA == R21)      ? r21_out :
                (iAddrA == R22)      ? r22_out :
                (iAddrA == R23)      ? r23_out :
                (iAddrA == Ret)      ? r24_out :
                (iAddrA == Rbt)      ? r25_out :
                (iAddrA == Rgp)      ? r26_out :
                (iAddrA == Rsp)      ? r27_out :
                (iAddrA == Rfp)      ? r28_out :
                (iAddrA == Rea)      ? r29_out :
                (iAddrA == Rsstatus) ? r30_out :
                (iAddrA == Rra)      ? r31_out :
                32'd0;

// Output Register A assignment
assign oRegB =  (iAddrB == R1)       ? r1_out  :
                (iAddrB == R2)       ? r2_out  :
                (iAddrB == R3)       ? r3_out  :
                (iAddrB == R4)       ? r4_out  :
                (iAddrB == R5)       ? r5_out  :
                (iAddrB == R6)       ? r6_out  :
                (iAddrB == R7)       ? r7_out  :
                (iAddrB == R8)       ? r8_out  :
                (iAddrB == R9)       ? r9_out  :
                (iAddrB == R10)      ? r10_out :
                (iAddrB == R11)      ? r11_out :
                (iAddrB == R12)      ? r12_out :
                (iAddrB == R13)      ? r13_out :
                (iAddrB == R14)      ? r14_out :
                (iAddrB == R15)      ? r15_out :
                (iAddrB == R16)      ? r16_out :
                (iAddrB == R17)      ? r17_out :
                (iAddrB == R18)      ? r18_out :
                (iAddrB == R19)      ? r19_out :
                (iAddrB == R20)      ? r20_out :
                (iAddrB == R21)      ? r21_out :
                (iAddrB == R22)      ? r22_out :
                (iAddrB == R23)      ? r23_out :
                (iAddrB == Ret)      ? r24_out :
                (iAddrB == Rbt)      ? r25_out :
                (iAddrB == Rgp)      ? r26_out :
                (iAddrB == Rsp)      ? r27_out :
                (iAddrB == Rfp)      ? r28_out :
                (iAddrB == Rea)      ? r29_out :
                (iAddrB == Rsstatus) ? r30_out :
                (iAddrB == Rra)      ? r31_out :
                32'd0;

// Registers
REG32 r1(  .iClk(iClk), .nRst(nRst), .iEn(r1_write),  .iD(iRegC), .oQ(r1_out)  );
REG32 r2(  .iClk(iClk), .nRst(nRst), .iEn(r2_write),  .iD(iRegC), .oQ(r2_out)  );
REG32 r3(  .iClk(iClk), .nRst(nRst), .iEn(r3_write),  .iD(iRegC), .oQ(r3_out)  );
REG32 r4(  .iClk(iClk), .nRst(nRst), .iEn(r4_write),  .iD(iRegC), .oQ(r4_out)  );
REG32 r5(  .iClk(iClk), .nRst(nRst), .iEn(r5_write),  .iD(iRegC), .oQ(r5_out)  );
REG32 r6(  .iClk(iClk), .nRst(nRst), .iEn(r6_write),  .iD(iRegC), .oQ(r6_out)  );
REG32 r7(  .iClk(iClk), .nRst(nRst), .iEn(r7_write),  .iD(iRegC), .oQ(r7_out)  );
REG32 r8(  .iClk(iClk), .nRst(nRst), .iEn(r8_write),  .iD(iRegC), .oQ(r8_out)  );
REG32 r9(  .iClk(iClk), .nRst(nRst), .iEn(r9_write),  .iD(iRegC), .oQ(r9_out)  );
REG32 r10( .iClk(iClk), .nRst(nRst), .iEn(r10_write), .iD(iRegC), .oQ(r10_out) );
REG32 r11( .iClk(iClk), .nRst(nRst), .iEn(r11_write), .iD(iRegC), .oQ(r11_out) );
REG32 r12( .iClk(iClk), .nRst(nRst), .iEn(r12_write), .iD(iRegC), .oQ(r12_out) );
REG32 r13( .iClk(iClk), .nRst(nRst), .iEn(r13_write), .iD(iRegC), .oQ(r13_out) );
REG32 r14( .iClk(iClk), .nRst(nRst), .iEn(r14_write), .iD(iRegC), .oQ(r14_out) );
REG32 r15( .iClk(iClk), .nRst(nRst), .iEn(r15_write), .iD(iRegC), .oQ(r15_out) );
REG32 r16( .iClk(iClk), .nRst(nRst), .iEn(r16_write), .iD(iRegC), .oQ(r16_out) );
REG32 r17( .iClk(iClk), .nRst(nRst), .iEn(r17_write), .iD(iRegC), .oQ(r17_out) );
REG32 r18( .iClk(iClk), .nRst(nRst), .iEn(r18_write), .iD(iRegC), .oQ(r18_out) );
REG32 r19( .iClk(iClk), .nRst(nRst), .iEn(r19_write), .iD(iRegC), .oQ(r19_out) );
REG32 r20( .iClk(iClk), .nRst(nRst), .iEn(r20_write), .iD(iRegC), .oQ(r20_out) );
REG32 r21( .iClk(iClk), .nRst(nRst), .iEn(r21_write), .iD(iRegC), .oQ(r21_out) );
REG32 r22( .iClk(iClk), .nRst(nRst), .iEn(r22_write), .iD(iRegC), .oQ(r22_out) );
REG32 r23( .iClk(iClk), .nRst(nRst), .iEn(r23_write), .iD(iRegC), .oQ(r23_out) );
REG32 r24( .iClk(iClk), .nRst(nRst), .iEn(r24_write), .iD(iRegC), .oQ(r24_out) );
REG32 r25( .iClk(iClk), .nRst(nRst), .iEn(r25_write), .iD(iRegC), .oQ(r25_out) );
REG32 r26( .iClk(iClk), .nRst(nRst), .iEn(r26_write), .iD(iRegC), .oQ(r26_out) );
REG32 r27( .iClk(iClk), .nRst(nRst), .iEn(r27_write), .iD(iRegC), .oQ(r27_out) );
REG32 r28( .iClk(iClk), .nRst(nRst), .iEn(r28_write), .iD(iRegC), .oQ(r28_out) );
REG32 r29( .iClk(iClk), .nRst(nRst), .iEn(r29_write), .iD(iRegC), .oQ(r29_out) );
REG32 r30( .iClk(iClk), .nRst(nRst), .iEn(r30_write), .iD(iRegC), .oQ(r30_out) );
REG32 r31( .iClk(iClk), .nRst(nRst), .iEn(r31_write), .iD(iRegC), .oQ(r31_out) );


endmodule

