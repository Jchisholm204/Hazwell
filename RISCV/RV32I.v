// RV32I Processor
module RV32I(
    iClk,
    nRst,
    iMemData,
    oMemAddr, oMemData,
    oMemWrite, oMemRead,
    iMemRdy
);

// Processor IO
input wire iClk, nRst;
input wire [31:0] iMemData;
output wire [31:0] oMemAddr, oMemData;
output wire oMemWrite, oMemRead;
input wire iMemRdy;

// Ready Signals
wire Rdy, Rdy_alu;

// Control
wire [4:0] Step;
wire op_alui, op_jalr, op_alur, op_lui, op_auipc, op_jal, op_branch, op_load, op_store;
// Instruction Decode
wire [31:0] IR_out, imm32_in, imm32_out;
wire [6:0] opcode;
wire [4:0] Rd, Rs1, Rs2;
wire [2:0] Funct3;
wire [6:0] Funct7;

// ALU
wire [3:0] ALUOP;
wire [31:0] ALU_A, ALU_B, ALU_out;
wire MB_Select;

// Register File
wire [31:0] RF_Rs1, RF_Rs2, RF_Rd;
wire RF_Write;

assign Rdy = (Step[0] && Rdy_mem) || (Step[1]) || (Step[2] && Rdy_alu) || (Step[3] && Rdy_mem) || (Step[4]);

assign MB_Select = op_load || op_store || op_branch || op_jalr || op_alui;
assign ALU_A = RF_Rs1;
assign ALU_B = MB_Select ? imm32_out : RF_Rs2;

// Registers

REG32 IMM32( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(imm32_in), .oQ(imm32_out) );

Control ControlUnit(
    .iClk(iClk),
    .nRst(nRst),
    .iOpcode(opcode),
    .iFunct3(Funct3),
    .iFunct7(Funct7),
    .iRdy(Rdy),
    .oT(Step),
    .alui(op_alui),
    .jalr(op_jalr),
    .alur(op_alur),
    .lui(op_lui),
    .auipc(op_auipc),
    .jal(op_jal),
    .branch(op_branch),
    .load(op_load),
    .store(op_store)
);

Decode Decoder(
    .iIR(IR_out),
    .oOpcode(opcode),
    .oRd(Rd),
    .oRs1(Rs1),
    .oRs2(Rs2),
    .oFunct3(Funct3),
    .oFunct7(Funct7),
    .oImm32(imm32_in)
);


RegFile RF(
    .iClk(iClk),
    .nRst(nRst),
    .iWrite(RF_Write),
    .iRd(Rd),
    .iRs1(Rs1),
    .iRs2(Rs2),
    .iWData(RF_Rd),
    .oRData1(RF_Rs1),
    .oRData2(RF_Rs2)
);

ALUControl ALU_Controller(
    .iOpcode(opcode),
    .iFunct3(Funct3),
    .iFunct7(Funct7),
    .oALUOP(ALUOP),
);

ALU ALU_inst(
    .iClk(iClk),
    .nRst(nRst),
    .iOP(ALUOP),
    .iA(ALU_A),
    .iB(ALU_B),
    .oC(ALU_out)
);

endmodule