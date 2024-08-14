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

// Control
wire [4:0] Step;
wire Rdy_ALU;
wire ctrl_load, ctrl_store,
     ctrl_branch, ctrl_jump, ctrl_jumpR,
     ctrl_regwrite, ctrl_pcwrite;
     ctrl_alu_imm, ctrl_alu_pc;
// Instruction Decode
wire [31:0] dec_imm32;
wire [6:0] dec_opcode;
wire [4:0] dec_rd, dec_rs1, dec_rs2;
wire [2:0] dec_func3;
wire [6:0] dec_func7;

// ALU
wire [3:0] alu_op;
wire [31:0] alu_ra, alu_rb, alu_rz;

// Branch/Jump Control
wire branch_jalx, branch_jalr;
wire [31:0] branch_addr;

// Register File
wire [31:0] rf_rs1, rf_rs2, rs_rd;
wire rf_write;

// Registers
wire reg_pc_en, reg_pc_tmp_en, reg_ir_en, reg_aluA_en, reg_aluB_en, reg_aluD_en;
wire [31:0] reg_pc_out, reg_pc_tmp_out, reg_ir_out, reg_aluA_out, reg_aluB_out, reg_aluD_out;

// Multiplexers
wire [31:0] mux_aluA, mux_aluB, mux_pc, mux_jump;
wire [31:0] pc_next;
assign pc_next = reg_pc_out + 31'd4;

assign mux_aluA = (ctrl_alu_imm) ? dec_imm32 : rf_rs1;
assign mux_aluB = (ctrl_alu_pc) ? reg_pc_out : rf_rs2;

assign mux_jump = (ctrl_jumpR) ? reg_aluD_out : branch_addr;
assign mux_pc = (branchOK) ? reg_aluD_out : pc_next;

// Registers
REG32 pc(
    .iClk(iClk),
    .nRst(nRst),
    .iEn(reg_pc_en),
    .iData(reg_pc_in),
    .oData(reg_pc_out)
);
REG32 pc_tmp(
    .iClk(iClk),
    .nRst(nRst),
    .iEn(reg_pc_tmp_en),
    .iData(reg_pc_tmp_in),
    .oData(reg_pc_tmp_out)
);
REG32 ir(
    .iClk(iClk),
    .nRst(nRst),
    .iEn(reg_ir_en),
    .iData(reg_ir_in),
    .oData(reg_ir_out)
);
REG32 aluA(
    .iClk(iClk),
    .nRst(nRst),
    .iEn(reg_aluA_en),
    .iData(reg_aluA_in),
    .oData(reg_aluA_out)
);
REG32 aluB(
    .iClk(iClk),
    .nRst(nRst),
    .iEn(reg_aluB_en),
    .iData(reg_aluB_in),
    .oData(reg_aluB_out)
);
REG32 aluD(
    .iClk(iClk),
    .nRst(nRst),
    .iEn(reg_aluD_en),
    .iData(reg_aluD_in),
    .oData(reg_aluD_out)
);

Control ControlUnit(
    .iClk(iClk),
    .nRst(nRst),
    .iOpcode(opcode),
    .iFunct3(Funct3),
    .iFunct7(Funct7),
    .iRdy_ALU(Rdy_ALU),
    .iRdy_MEM(iMemRdy),
    .oStep(Step),
    .oLoad(ctrl_load),
    .oStore(ctrl_store),
    .oBranch(ctrl_branch),
    .oJump(ctrl_jump),
    .oJumpR(ctrl_jumpR),
    .oRegWrite(ctrl_regwrite),
    .oPCWrite(ctrl_pcwrite),
    .oALU_IMM(ctrl_alu_imm),
    .oALU_PC(ctrl_alu_pc)
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
    .iOP(alu_op),
    .oRdy(Rdy_ALU),
    .iA(alu_ra),
    .iB(alu_rb),
    .oC(alu_rz)
);

endmodule