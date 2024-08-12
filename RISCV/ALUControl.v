module ALUControl (
    iOpcode,
    iFunct3,
    iFunct7,
    oALUOP,
);

// ALU Operations
parameter ALU_ADD = 4'h0;
parameter ALU_SUB = 4'h1;
parameter ALU_XOR = 4'h2;
parameter ALU_OR = 4'h3;
parameter ALU_AND = 4'h4;
parameter ALU_SLL = 4'h5;
parameter ALU_SRL = 4'h6;
parameter ALU_SRA = 4'h7;
parameter ALU_SLT = 4'h8;
parameter ALU_SLTU = 4'h9;

input  wire [6:0] iOpcode;
input  wire [2:0] iFunct3;
input  wire [6:0] iFunct7;
output wire [3:0] oALUOP;

// Wires for ALU Control under different instruction types
wire [3:0] aluop_r, aluop_i;

assign aluop_r = (iFunct3 == 3'h0 && iFunct7 == 7'h00) ? ALU_ADD :
                 (iFunct3 == 3'h0 && iFunct7 == 7'h20) ? ALU_SUB :
                 (iFunct3 == 3'h4 && iFunct7 == 7'h00) ? ALU_XOR :
                 (iFunct3 == 3'h6 && iFunct7 == 7'h00) ? ALU_OR  :
                 (iFunct3 == 3'h7 && iFunct7 == 7'h00) ? ALU_AND :
                 (iFunct3 == 3'h1 && iFunct7 == 7'h00) ? ALU_SLL :
                 (iFunct3 == 3'h5 && iFunct7 == 7'h00) ? ALU_SRL :
                 (iFunct3 == 3'h5 && iFunct7 == 7'h20) ? ALU_SRA :
                 (iFunct3 == 3'h2 && iFunct7 == 7'h00) ? ALU_SLT :
                 (iFunct3 == 3'h3 && iFunct7 == 7'h00) ? ALU_SLTU : ALU_ADD;

assign aluop_i = (iFunct3 == 3'h0)                        ? ALU_ADD :
                 (iFunct3 == 3'h4)                        ? ALU_XOR :
                 (iFunct3 == 3'h6)                        ? ALU_OR  :
                 (iFunct3 == 3'h7)                        ? ALU_AND :
                 (iFunct3 == 3'h1 && iFunct7 == 7'h00)    ? ALU_SLL :
                 (iFunct3 == 3'h5 && iFunct7 == 7'h00)    ? ALU_SRL :
                 (iFunct3 == 3'h5 && iFunct7 == 7'h20)    ? ALU_SRA :
                 (iFunct3 == 3'h2)                        ? ALU_SLT :
                 (iFunct3 == 3'h3)                        ? ALU_SLTU : ALU_ADD;

// Use the correct ALU operation for each instruction
// R-Type and I-Type instructions use different Encodings
// Other instructions use ALU_ADD
assign oALUOP = (iOpcode == Control.R_TYPE) ? aluop_r :
                (iOpcode == Control.I_TYPE) ? aluop_i : ALU_ADD;

endmodule