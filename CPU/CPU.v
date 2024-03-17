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
wire [31:0] PC_adder_out;

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
wire [31:0] MuxY_out;

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
wire [10:0] IR_OPX;
wire [4:0] IR_src1;
wire [4:0] IR_src2;
wire [4:0] IR_dest;
wire [15:0] IR_imm16;
wire [25:0] IR_imm26;

// 32 Bit sign extended immediate value
reg [31:0] imm32;

// Multiplexer control signals
reg B_Select, INC_Select, MA_Select, PC_Select;
reg [1:0] C_Select, Y_Select;

wire PC_en, PC_temp_en, IR_en;

// =========================================================== //

// Create the REGFile
RegFile u0(
    .iClk(iClk),
    .nRst(nRst),
    .iWrite(RF_write),
    .iAddrA(IR_src1),
    .iAddrB(IR_src2),
    .iAddrC(Addr_C),
    .oRegA(Reg_A),
    .oRegB(Reg_B),
    .iRegC(RY_out)
);

// Create the ALU
ALU u1(
    .iOP(ALU_op),
    .iRegA(RA_out),
    .iRegB(RB_out),
    .oRegC(ALU_out),
    .oNEG(ALU_neg_out),
    .oZERO(ALU_zero_out)
);

// System Registers (For use within the Datapath)

REG32 PC      ( .iClk(iClk), .nRst(nRst), .iEn(PC_en), .iD(MuxPC_out), .oQ(PC_out) );
REG32 PC_Temp ( .iClk(iClk), .nRst(nRst), .iEn(PC_temp_en), .iD(PC_out), .oQ(PC_TEMP_out) );
REG32 IR      ( .iClk(iClk), .nRst(nRst), .iEn(IR_en), .iD(iMemData), .oQ(IR_out) );
REG32 RA      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(Reg_A), .oQ(RA_out) );
REG32 RB      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(Reg_B), .oQ(RB_out) );
REG32 RM      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(RB_out), .oQ(RM_out) );
REG32 RY      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(MuxY_out), .oQ(RY_out) );
REG32 RZ      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1), .iD(ALU_out), .oQ(RZ_out) );

// ========================================================================== //

// PC Adder
assign PC_adder_out = PC_out + MuxINC_out;

// imm16 to imm32 sign extension
assign imm32[31:16] = {16{IR_imm16[15]}};
assign imm32[15:0]  = IR_imm16;

// Multiplexers
assign MuxB_out = B_Select ? imm32 : RB_out;
assign MuxC_out = C_Select ? IR_dest : IR_src2;
assign MuxINC_out = INC_Select ? imm32 : 32'd4;
assign MuxMA_out = MA_Select ? PC_out : RZ_out;
assign MuxPC_out = PC_Select ? PC_adder_out : RA_out;
assign MuxY_out =   (Y_Select == 2'b10) ? PC_TEMP_out :
                    (Y_Select == 2'b10) ? iMemData :
                    RZ_out;


// Instruction Register Decoding
assign IR_src1 = IR_out[31:27];
assign IR_src2 = IR_out[26:22];
assign IR_dest = IR_out[21:17];
assign IR_imm16 = IR_out[21:6];
assign IR_imm26 = IR_out[31:6];
assign IR_OPX = IR_out[16:6];
assign IR_Opcode = IR_out[5:0];

// Opcode Decoding
assign INS_addi = (IR_Opcode == 6'b000100);
assign INS_br = (IR_Opcode == 6'b000110);
assign INS_ldw = (IR_Opcode == 6'b000111);
assign INS_stw = (IR_Opcode == 6'b000101);

// Memory control signals
assign oMemRW = (Step[1] || (Step[4] && INS_ldw)); // Conditional for mem read
assign oMemEn = Step[1] || Step[4]; // Conditional for any mem operation

// Memory Outputs
assign oMemAddr = MuxMA_out;
assign oMemData = RM_out;

// Multiplexer Control Signals
assign B_Select = 1'b1; // ALU Input
assign C_Select = 2'b00; // Set SRC2 as destination register
assign INC_Select = Step[2] && INS_br; // Use imm32 offset for br, otherwise +4
assign MA_Select = Step[0]; // use PC for ifetch, otherwise RZ
assign PC_Select = 1'b1;
assign Y_Select = (Step[3] && INS_ldw) ? 2'b01 : 2'b00;

// Load enable for Program Counter
assign PC_en = Step[0] || (Step[2] && INS_br);
assign PC_temp_en = Step[2]; //Should be T3 and INs_call when call supported

assign IR_en = Step[0];

assign ALU_op = 4'b0000;

assign RF_write = Step[4] && (INS_ldw || INS_addi);

// One hot step counter;
always@(posedge iClk or negedge nRst)
begin
    if(!nRst) Step = 5'b00001;
    else Step = {Step[4:1], Step[5]};
end

endmodule
