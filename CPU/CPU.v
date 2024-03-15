module CPU (
    iClk, nRst,
    oMemAddr, oMemData,
    iMemData,
    oMemRW, oMemEn
);

// External Signals
input wire iClk, nRst;
output wire [31:0] oMemAddr, oMemData;
input wire  [31:0] iMemData;
output wire        oMemRW, oMemEn;

// Internal Signals

// Instruction Fetch Datapath
wire [31:0] PC_out, PC_TEMP_out, IR_out;
wire [31:0] RA_out, RB_out, RM_out;
wire [31:0] RX_out, RY_out, RZ_out;

// Combinational output from PC Adder
reg [31:0] PC_adder_out;

// ALU
reg [3:0] ALU_op;
wire [31:0] ALU_out;
wire ALU_zero_out, ALU_neg_out;

// Instruction fetch multiplexer outputs

wire [31:0] MuxB_out;
wire [4:0] MuxC_out;
wire [31:0] MuxINC_out;
wire [31:0] MuxMA_out;
wire [31:0] MuxPC_out;
wire [31:0] MuxY_out

// One hot step counter
reg [4:0] Step;

// Outputs from instruction decoder
wire INS_addi, INS_br, INS_ldw, INS_stw;

// Register File
wire [5:0] Addr_A, Addr_B, Addr_C; // A/B unused
wire [31:0] Reg_A, Reg_B;
wire RF_write;

// Instruction Register Decoded
wire [5:0] IR_Opcode;
wire [4:0] IR_src1;
wire [4:0] IR_src2;
wire [4:0] IR_dest;
wire [15:0] IR_imm16;

// 32 Bit sign extended immediate value
reg [31:0] imm32;

// Multiplexer control signals
reg B_Select, INC_Select, MA_Select, PC_Select;
reg [1:0] C_Select, Y_Select;

wire PC_en, PC_temp_en, IR_en;

// =========================================================== //


// System Registers (For use within the Datapath)

REG32 PC      ( .iClk(iClk), .nRst(nRst), .iEn(PC_en), .iD(MuxPC_out), .oQ(PC_out) );
REG32 PC_Temp ( .iClk(iClk), .nRst(nRst), .iEn(PC_temp_en), .iD(PC_out), .oQ(PC_TEMP_out) );
REG32 IR      ( .iClk(iClk), .nRst(nRst), .iEn(IR_en), .iD(iMemData), .oQ(IR_out) );
REG32 RA      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(Reg_A), .oQ(RA_out) );
REG32 RB      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(Reg_B), .oQ(RB_out) );
REG32 RM      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(RB_out), .oQ(RM_out) );
REG32 RY      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(MuxY_out), .oQ(RY_out) );
REG32 RZ      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(ALU_out), .oQ(RZ_out) );

// Create the REGFile
RegFile rf(
    .iClk(iClk),
    .nRst(nRst),
    .iWrite(RF_write),
    .iAddrA(IR_src1),
    .iAddrB(IR_src2),
    .iAddrC(Addr_C),
    .oRegA(Reg_A),
    .oRegA(Reg_B),
    .iRegC(RY_out)
);

// One hot step counter;
always@(posedge iClk or negedge nRst)
begin
    if(!nRst) Step = 5'b00001;
    else Step = {Step[4:1], Step[5]};

endmodule
