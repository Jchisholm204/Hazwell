`timescale 1ns/1ns
module CPU_TB();

reg CLK, RST;
wire MemoryWrite, MemoryRead;
wire [31:0] MemAddr, cpu_to_mem;
reg [31:0] mem_to_cpu;

CPU u0(
    .iClk(CLK),
    .nRst(RST),
    .oMemAddr(MemAddr),
    .oMemData(cpu_to_mem),
    .iMemData(mem_to_cpu),
    .oMemRead(MemoryRead),
    .oMemWrite(MemoryWrite)
);

// define constant bit patterns for test instructions
// .... SRC1       SRC2     IMM16                OPCODE .....
parameter [31:0] LOAD_R1  = 32'b0000100010000000000001010111;
parameter [31:0] STORE_R1 = 32'b0000100010000000000001010101;
parameter [31:0] ADDI_R1  = 32'b000100010000000000000000000100;
parameter [31:0] BR_START = 32'b00000000000011111111111100000110;


initial begin
    forever begin
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;
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
        32'h00000004: mem_to_cpu = ADDI_R1;
        32'h00000008: mem_to_cpu = STORE_R1;
        32'h0000000C: mem_to_cpu = BR_START;
        default: mem_to_cpu = 31'h7;
    endcase
end

endmodule
