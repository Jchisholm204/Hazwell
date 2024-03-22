`timescale 1ns/1ns
module CPU_TB();

reg CLK, RST, RDY;
wire MemoryWrite, MemoryRead;
wire [31:0] MemAddr, cpu_to_mem;
reg [31:0] mem_to_cpu;
reg [31:0] temp1 = 32'd2;
reg [31:0] temp2 = 32'd1;


PROCESSOR proc(
    .iClk(CLK),
    .nRst(RST),
    .iRDY(RDY),
    .oMemAddr(MemAddr),
    .oMemData(cpu_to_mem),
    .iMemData(mem_to_cpu),
    .oMemRead(MemoryRead),
    .oMemWrite(MemoryWrite)
);

parameter [4:0] R0 = 5'b00000;
parameter [4:0] R1 = 5'b00001;
parameter [4:0] R2 = 5'b00010;
parameter [4:0] R3 = 5'b00011;

parameter [5:0] OP_LDW = 6'h17;
parameter [5:0] OP_STW = 6'h15;
parameter [5:0] OP_ADDI = 6'h04;
parameter [5:0] OP_BR = 6'h06;
parameter [5:0] OP_BLT = 6'h16;
parameter [5:0] OP_BEQ = 6'h26;
parameter [5:0] OP_R = 6'h3A;

parameter [10:0] OPX_ADD = {6'h31, 5'h0};
parameter [10:0] OPX_SUB = {6'h39, 5'h0};

parameter [15:0] ADDR  = 16'h1000;
parameter [15:0] BR_ADDR = 16'b1111111111110000;


// Test Instructions
// SRC1, SRC2, Imm16, Opcode
// SRC1, SRC2, Dest, OPX, OP_R
parameter [31:0] LOAD_R1  = {R0, R1, 16'h1000, OP_LDW};
parameter [31:0] LOAD_R2  = {R0, R2, 16'h1004, OP_LDW};
parameter [31:0] STORE_R1 = {R0, R1, ADDR, OP_STW};
parameter [31:0] ADDI_R1  = {R1, R1, 16'b11111111111111111, OP_ADDI};
parameter [31:0] ADD_R1R2  = {R2, R1, R1, OPX_ADD, OP_R};
parameter [31:0] SUB_R1R2  = {R1, R2, R1, OPX_SUB, OP_R};
parameter [31:0] BR_START = {R0, R1, 16'b1111111111101100, OP_BR};
parameter [31:0] BR_R0R1 = {R0, R1, BR_ADDR, OP_BLT};


initial begin
    RDY = 1'b1;
    forever begin
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;
        if(MemoryRead || MemoryWrite) begin
            RDY = 1'b1;
            //#15;
            RDY = 1'b1;
        end
        else RDY = 1'b1;
    end
end

initial begin
    RST = 1'b0;
    #10;
    RST = 1'b1;
end


// model the full memory output for instruction and data addresses
always @* begin
    case(MemAddr)
        32'h00000000: mem_to_cpu = LOAD_R1;
        32'h00000004: mem_to_cpu = LOAD_R2;
        32'h00000008: mem_to_cpu = SUB_R1R2;
        32'h0000000C: mem_to_cpu = STORE_R1;
        32'h00000010: mem_to_cpu = BR_R0R1;
        32'h1000: mem_to_cpu = temp1;
        32'h1004: mem_to_cpu = temp2;
        default: mem_to_cpu = 32'd0;
    endcase

    if(MemoryWrite) begin
        case(MemAddr)
            32'h1000: temp1 = cpu_to_mem;
            32'h1004: temp2 = cpu_to_mem;
        endcase
end
end

endmodule
