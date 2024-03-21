module CPU (
    iClk, nRst,
    oMemAddr, oMemData,
    iMemData,
    oMemWrite, oMemRead
);

// External Signals
input wire iClk, nRst;
output wire [31:0] oMemAddr, oMemData;
input wire  [31:0] iMemData;
output wire        oMemWrite, oMemRead;

// Internal Signals //

// Instruction Fetch Datapath
wire [31:0] PC_out, PC_TEMP_out, IR_out;
wire [31:0] RA_out, RB_out, RM_out;
wire [31:0] RY_out, RZ_out;

// Combinational output from PC Adder
wire [31:0] PC_adder_out;

// ALU
wire [3:0] ALU_op;
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
reg T1, T2, T3, T4, T5;


// Register File
wire [4:0] RF_AddrA, RF_AddrB, RF_AddrC; // AB unused
wire [31:0] RF_oA, RF_oB;
wire RF_Write;


// One Hot outputs from I-Type Instructions
wire INS_addi, INS_br, INS_ldw, INS_stw, INS_call, INS_Rtype;
// One Hot outputs from R-Type Instructions
wire INSX_add, INSX_sub;
// Redirect Instructions
wire INS_beq, INS_blt;

// Instruction Register Segments
wire [5:0] IR_Opcode;
wire [10:0] IR_OPX; // Extened OPCODE
wire [4:0] IR_src1;
wire [4:0] IR_src2;
wire [4:0] IR_dest;
// Instruction Register Immediate Values
wire [15:0] IR_imm16; // From IR (I-Type)
wire [25:0] IR_imm26; // For Call Instructions (J-Type)
wire [31:0] imm32;    // Sign Extened IR_imm16

// imm16 to imm32 sign extension
assign imm32[31:16] = {16{IR_imm16[15]}};
assign imm32[15:0]  = IR_imm16;

// Instruction Register Decoding

assign IR_src1   = IR_out[31:27];
assign IR_src2   = IR_out[26:22];
assign IR_dest   = IR_out[21:17];
assign IR_imm16  = IR_out[21:6];
assign IR_imm26  = IR_out[31:6];
assign IR_OPX    = IR_out[16:6];
assign IR_Opcode = IR_out[5:0];


// Multiplexer control signals
wire B_Select, INC_Select, MA_Select, PC_Select;
wire [1:0] C_Select, Y_Select;

wire PC_en, PC_temp_en, IR_en;


//**********  Begin Register File ************//

// Register File Address inputs
assign RF_AddrA = IR_src1;
assign RF_AddrB = IR_src2;
assign RF_AddrC = MuxC_out;

assign RF_Write = T5 && (INS_ldw || INS_addi || INSX_add || INSX_sub);

RegFile u0(
    .iClk(iClk),
    .nRst(nRst),
    .iWrite(RF_Write),
    .iAddrA(RF_AddrA),
    .iAddrB(RF_AddrB),
    .iAddrC(RF_AddrC),
    .oRegA(RF_oA),
    .oRegB(RF_oB),
    .iRegC(RY_out)
);

//**********  End Register File  ************//

//**********  Begin ALU  ************//

assign ALU_op = (INS_addi || INSX_add) ? 4'b0000 :
                (INSX_sub)             ? 4'b0001 :
                                         4'b0000 ;
// Create the ALU
ALU u1(
    .iOP(ALU_op),
    .iRegA(RA_out),
    .iRegB(MuxB_out),
    .oRegC(ALU_out),
    .oNEG(ALU_neg_out),
    .oZERO(ALU_zero_out)
);

//**********  End ALU  ************//


//**********  Begin System Registers  ************//


// Load Enable Signals
assign PC_en = T1 || (T3 && INS_br);
assign PC_temp_en = T3 && INS_call; //Should be T3 and INs_call when call supported
assign IR_en = T1;

// System Registers (For use within the Datapath)
REG32 PC      ( .iClk(iClk), .nRst(nRst), .iEn(PC_en),      .iD(MuxPC_out), .oQ(PC_out) );
REG32 PC_Temp ( .iClk(iClk), .nRst(nRst), .iEn(PC_temp_en), .iD(PC_out),    .oQ(PC_TEMP_out) );
REG32 IR      ( .iClk(iClk), .nRst(nRst), .iEn(IR_en),      .iD(iMemData),  .oQ(IR_out) );
REG32 RA      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1),       .iD(RF_oA),     .oQ(RA_out) );
REG32 RB      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1),       .iD(RF_oB),     .oQ(RB_out) );
REG32 RM      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1),       .iD(RB_out),    .oQ(RM_out) );
REG32 RY      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1),       .iD(MuxY_out),  .oQ(RY_out) );
REG32 RZ      ( .iClk(iClk), .nRst(nRst), .iEn(1'b1),       .iD(ALU_out),   .oQ(RZ_out) );

//**********  End System Registers  ************//



// PC Adder
assign PC_adder_out = PC_out + MuxINC_out;

// Multiplexer Control Signals
assign B_Select = ~INS_Rtype; // ALU Input
assign C_Select = INS_Rtype ?  2'b01 : 2'b00; // RegFile AddrC Select - IRsrc2, IRdest, Link
assign INC_Select = T3 && INS_br; // Use imm32 offset for br, otherwise +4
assign MA_Select = T1; // use PC for ifetch, otherwise RZ
assign PC_Select = 1'b1; // always use PC_adder_out for now
assign Y_Select = (T4 && INS_ldw) ? 2'b01 : 2'b00;


// Multiplexers
assign MuxB_out   = B_Select   ? imm32        : RB_out;
assign MuxINC_out = INC_Select ? imm32        : 32'd4;
assign MuxMA_out  = MA_Select  ? PC_out       : RZ_out;
assign MuxPC_out  = PC_Select  ? PC_adder_out : RA_out;
assign MuxY_out   = (Y_Select == 2'b10) ? PC_TEMP_out :
                    (Y_Select == 2'b01) ? iMemData    :
                    RZ_out;
assign MuxC_out   = (C_Select == 2'b01) ? IR_dest : IR_src2;


// Opcode Decoding (I-Type Instructions)
assign INS_addi = (IR_Opcode == 6'b000100);
assign INS_br = (IR_Opcode == 6'b000110) || (INS_beq && (RA_out == RB_out)) || (INS_blt && (RA_out < RB_out));
assign INS_ldw = (IR_Opcode == 6'b010111);
assign INS_stw = (IR_Opcode == 6'b010101);
assign INS_beq = (IR_Opcode == 6'h26);
assign INS_blt = (IR_Opcode == 6'h16);
assign INS_Rtype = (IR_Opcode == 6'h3A);

// Opcode Decoding (J-Type Instructions)
assign INSX_add = INS_Rtype && (IR_OPX == {6'h31, 5'h0});
assign INSX_sub = INS_Rtype && (IR_OPX == {6'h39, 5'h0});

// Memory control signals
assign oMemRead = (T1 || (T4 && INS_ldw)); // Conditional for Memory Read
assign oMemWrite = T4 && INS_stw; // Conditional for Memory Write

// Memory Outputs
assign oMemAddr = MuxMA_out;
assign oMemData = RM_out;


// One hot step counter;
always@(posedge iClk or negedge nRst)
begin
    if(!nRst) begin
        T1 <= 1'b1;
        T2 <= 1'b0;
        T3 <= 1'b0;
        T4 <= 1'b0;
        T5 <= 1'b0;
    end
    else begin
        T1 <= T5;
        T2 <= T1;
        T3 <= T2;
        T4 <= T3;
        T5 <= T4;
    end
end

endmodule
