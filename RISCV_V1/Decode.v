// Instruction register decoder
module Decode(
    iIR,
    oOpcode,
    oRd, oRs1, oRs2,
    oFunct3, oFunct7,
    oImm32,
);

input wire [31:0] iIR;
output wire [6:0] oOpcode;
output wire [4:0] oRd, oRs1, oRs2;
output wire [2:0] oFunct3;
output wire [6:0] oFunct7;
output wire [31:0] oImm32;

// Opcode Types
parameter I_TYPE = 6'b0010011;
parameter R_TYPE = 6'b0110011;
parameter U_TYPE = 6'b0110111;
parameter J_TYPE = 6'b1101111;
parameter B_TYPE = 6'b1100011;
parameter S_TYPE = 6'b0100011;

// Wires for Immediate Values under different instruction types
wire [31:0] immI, immS, immB, immU, immJ;

wire [6:0] opcode;

// Decode Immediate Values
assign immI = { {20{iIR[31]}}, iIR[31:20] };
assign immS = { {20{iIR[31]}}, iIR[31:25], iIR[11:7] };
assign immB = { {19{iIR[31]}}, iIR[7], iIR[30:25], iIR[11:8], 1'b0 };
assign immU = { iIR[31:12], 12'd0 };
assign immJ = { {11{iIR[31]}}, iIR[19:12], iIR[20], iIR[30:21], 1'b0 };

// Use the correct immediate value encoding for each instruction
assign oImm32 = (opcode == I_TYPE) ? immI :
                (opcode == S_TYPE) ? immS :
                (opcode == B_TYPE) ? immB :
                (opcode == U_TYPE) ? immU :
                (opcode == J_TYPE) ? immJ : 32'd0;

assign opcode = iIR[6:0];
assign oOpcode = opcode;
assign oRd = iIR[11:7];
assign oRs1 = iIR[19:15];
assign oRs2 = iIR[24:20];
assign oFunct3 = iIR[14:12];
assign oFunct7 = iIR[31:25];


endmodule