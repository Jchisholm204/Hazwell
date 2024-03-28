module proc(
    iClk, nRst, iRdy,
    oMemAddr, iMemData, oMemData,
    oMemWrite, oMemRead
);

// Module IO
input wire iClk, nRst, iRdy;
input wire [31:0] iMemData;
output wire [31:0] oMemData, oMemAddr;
output wire oMemWrite, oMemRead;

// Program Counter
wire [31:0] PC_in, PC_out, PC_Add;
wire [31:0] PCT_out;
wire [31:0] PC_Adder_out, PC_Call;
wire PC_en, PCT_en;
REG32 PC  (.iClk(iClk), .nRst(nRst), .iEn(PC_en),  .iD(PC_in),  .oQ(PC_out));
REG32 PCT (.iClk(iClk), .nRst(nRst), .iEn(PCT_en), .iD(PC_out), .oQ(PCT_out));


// Memory Data
wire [31:0] IR_out, MDR_out, MAR_in, MOR_in;
wire IR_en, MDR_en, MAR_en, MOR_en;
REG32 IR  (.iClk(iClk), .nRst(nRst), .iEn(IR_en),  .iD(iMemData), .oQ(IR_out));
REG32 MDR (.iClk(iClk), .nRst(nRst), .iEn(MDR_en), .iD(iMemData), .oQ(MDR_out));
REG32 MOR (.iClk(iClk), .nRst(nRst), .iEn(MOR_en), .iD(MOR_in), .oQ(oMemData));
REG32 MAR (.iClk(iClk), .nRst(nRst), .iEn(MAR_en), .iD(MAR_in),   .oQ(oMemAddr));


// Register File
wire RF_Write;
wire [4:0] RF_AddrA, RF_AddrB, RF_AddrC; // Addresses
wire [31:0] RF_RA, RF_RB, RF_RC; // Register Data

registers regs( .iClk(iClk),       .nRst(nRst),       .iWrite(RF_Write),
                .iAddrA(RF_AddrA), .iAddrB(RF_AddrB), .iAddrC(RF_AddrC),
                .oRegA(RF_RA),     .oRegB(RF_RB),     .iRegC(RF_RC)
              );


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
wire    MAR_Select,  // Memory Address Select
        ALUB_Select, // ALU B input Select
        PCA_Select;  // Program Counter Adder Select
wire [1:0]  PC_Select,    // Program Counter IN Select
            C_Select,     // Register File Write Select
            AddrC_Select; // Register File Write Register Select

// Instruction Register Data
wire [15:0] IR_imm16;
wire [31:0] IR_imm32;
wire [25:0] IR_immCall;
wire [5:0]  IR_src1, IR_src2, IR_dest;
wire [16:0] IR_OP;


// Control Unit]

control controller( .iOP(IR_OP),   .iRdy(iRdy),
                    .PC_en(PC_en), .PCT_en(PCT_en), .IR_en(IR_en), .MDR_en(MDR_en), .MOR_en(MOR_en),
                    .RF_Write(RF_Write),
                    .ALU_op(ALU_op),
                    .MAR_Select(MAR_Select), .ALUB_Select(ALUB_Select), .PCA_Select(PCA_Select),
                    .PC_Select(PC_Select),   .C_Select(C_Select),       .AddrC_Select(AddrC_Select)
                  );


// Multiplexers
// Memory Address => PC | imm32 + [Ra]
assign MAR_in = MAR_Select ? PC_out : ALU_out;

// ALU B input => Immediate | Register B
assign ALU_RB = ALUB_Select ? IR_imm32 : RB_out;

// PC Adder In => Branch | Next Instruction
assign PC_Add = PCA_Select ? IR_imm32 : 31'd4;

// PC Input => Return Addr | Call Addr | Next Instruction
assign PC_in  = (PC_Select == 2'b10) ? RA_out : 
                (PC_Select == 2'b01) ? PC_Call:
                PC_Adder_out;

// Register File Write Address => Link Register | IR destination | IR Source 2
assign RF_AddrC =   (AddrC_Select == control.C_Select_RA) ? registers.AddrRA : 
                    (AddrC_Select == 2'b01) ? IR_dest  :
                    IR_src2;
// Register File Write Data => PC Temp | Memory Data In | ALU Output
assign RF_C =   (C_Select == 2'b10) ? PCT_out :
                (C_Select == 2'b01) ? MDR_out :
                ALU_out;

// Memory Data Out
assign MOR_in = RB_out;

// Program Counter Arithmatic
assign PC_Adder_out = PC_out + PC_Add;
assign PC_Call[31:2] = {PC_out[31:28], IR_immCall[25:0]};
assign PC_Call[1:0] = 2'b00;

endmodule
