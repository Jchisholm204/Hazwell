`timescale 1ns/1ns
module CPU_TB();

reg CLK, RST;
wire MemoryWrite, MemoryRead;
wire [31:0] MemAddr, cpu_to_mem;
reg [31:0] mem_to_cpu, temp = 32'd5;

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
parameter [31:0] LOAD_R1  = 32'b00000000010001000000000000010111;
parameter [31:0] STORE_R1 = 32'b00000000010001000000000000010101;
parameter [31:0] ADDI_R1  = 32'b00001000010000000000000001000100;
parameter [31:0] BR_START = 32'b00000000001111111111110000000110;


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
        default: mem_to_cpu = temp;
    endcase
    if(MemoryWrite) temp = cpu_to_mem;
end

endmodule
