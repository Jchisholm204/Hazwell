module Memory(
    iClk,
    nRst,
    iMemData, iMemAddr,
    oMemData,
    iMemWrite, iMemRead,
    oMemRdy,
);


input wire iClk, nRst;
input wire [31:0] iMemData, iMemAddr;
output wire [31:0] oMemData;
input wire iMemWrite, iMemRead;
output wire oMemRdy;

assign oMemData = 32'd0;
assign oMemRdy = 1'b1;

endmodule