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

// Memory Data
wire [31:0] IR_out, MDR_out;
wire IR_en, MDR_en;
REG32 IR (.iClk(iClk), .nRst(nRst), .iEn(IR_en), .iD(iMemData), .oQ(IR_out));
REG32 MDR (.iClk(iClk), .nRst(nRst), .iEn(MDR_en), .iD(iMemData), .oQ(MDR_out));


// Register File
wire [4:0] RF_AddrA, RF_AddrB, RF_AddrC; // Addresses
wire [31:0] RF_RA, RF_RB, RF_RC; // Register Data
wire RF_Write;

registers regs( .iClk(iClk), .nRst(nRst), .iWrite(RF_Write), .iAddrA(RF_AddrA), .iAddrB(RF_AddrB), .iAddrC(RF_AddrC), .oRegA(RF_RA), .oRegB(RF_RB), .iRegC(RF_RC));

wire [31:0] RA_out, RB_out;
wire RA_en, RB_en;

REG32 RA (.iClk(iClk), .nRst(RA_en), .iD(RF_RA), .oQ(RA_out));
REG32 RB (.iClk(iClk), .nRst(RB_en), .iD(RF_RB), .oQ(RB_out));

assign RA_en = 1'b1;
assign RB_en = 1'b1;

// ALU
wire [5:0] ALU_op;
wire ALU_zero, ALU_neg;
wire [31:0] ALU_RA, ALU_RB, ALU_RC;

ALU alu(.OP(ALU_op), .oZero(ALU_zero), .oNeg(ALU_neg), .iRA(ALU_RA), .iRB(ALU_RB), .oRC(ALU_RC));






endmodule
