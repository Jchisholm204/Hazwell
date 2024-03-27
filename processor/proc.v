module proc(
    iClk, nRst,
    oMemAddr, iMemData, oMemData,
    oMemWrite, oMemRead
);

// Module IO
input wire iClk, nRst;
input wire [31:0] iMemData;
output wire [31:0] oMemData, oMemAddr;
output wire oMemWrite, oMemRead;

// Program Counter
wire [31:0] PC_in, PC_out;
wire PC_en;
REG32 PC (.iClk(iClk), .nRst(nRst), .iEn(PC_en), .iD(PC_in), .oQ(PC_out));

// Memory Data
wire [31:0] IR_out, MDR_out, MAR_in;
wire IR_en, MDR_en, MAR_en;
REG32 IR (.iClk(iClk), .nRst(nRst), .iEn(IR_en), .iD(iMemData), .oQ(IR_out));
REG32 MDR (.iClk(iClk), .nRst(nRst), .iEn(MDR_en), .iD(iMemData), .oQ(MDR_out));
REG32 MAR (.iClk(iClk), .nRst(nRst), .iEn(MAR_en), .iD(MAR_in), .oQ(oMemAddr));


// Register File
wire [4:0] RF_AddrA, RF_AddrB, RF_AddrC; // Addresses
wire [31:0] RF_RA, RF_RB, RF_RC; // Register Data
wire RF_Write;

registers regs( .iClk(iClk), .nRst(nRst), .iWrite(RF_Write), .iAddrA(RF_AddrA), .iAddrB(RF_AddrB), .iAddrC(RF_AddrC), .oRegA(RF_RA), .oRegB(RF_RB), .iRegC(RF_RC));

// Registers to hold RF Outputs
wire [31:0] RA_out, RB_out;

REG32 RA (.iClk(iClk), .nRst(1'b1), .iD(RF_RA), .oQ(RA_out));
REG32 RB (.iClk(iClk), .nRst(1'b1), .iD(RF_RB), .oQ(RB_out));


// ALU
wire [5:0] ALU_op;
wire ALU_zero, ALU_neg;
wire [31:0] ALU_RA, ALU_RB, ALU_RC;

ALU alu(.OP(ALU_op), .oZero(ALU_zero), .oNeg(ALU_neg), .iRA(ALU_RA), .iRB(ALU_RB), .oRC(ALU_RC));

// ALU output register
wire [31:0] ALU_out;
REG32 RALU (.iClk(iClk), .nRst(1'b1), .iD(ALU_RC), .oQ(ALU_out));


// Datapath Control Signals
wire MAR_Select, ALUB_Select, AddrC_Select, PCA_Select;
wire [1:0] PC_Select, C_Select;

// Control Unit



// Memory Data Out





endmodule
