module CPU_TB();

reg CLK;
wire MemRW, MemEN;
wire [31:0] MemAddr, oMemData;
reg [31:0] iMemData;

CPU u0(
    .iClk(CLK),
    .nRst(1'b1),
    .oMemAddr(MemAddr),
    .oMemData(oMemData),
    .iMemData(iMemData),
    .oMemRW(MemRW),
    .oMemEn(MemEN)
);

initial begin
    forever begin
        CLK = 0;
        #10 CLK = ~CLK;

endmodule
