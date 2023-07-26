module sevensegments (
    iClk_50,
    iNum,
    eBlink,
    HEX0,
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    HEX6,
    HEX7
);

input   wire iClk_50;
        wire nRst;
input   wire [7:0] iNum;
input   wire eBlink;
output  wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
reg [7:0] Seg0, Seg1, Seg2, Seg3;

assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;
assign HEX6 = 7'b1111111;
assign HEX7 = 7'b1111111;
assign nRst = 1'b1;

always @(posedge iClk_50 ) begin
    Seg0 <= iNum      % 10;
    Seg1 <= iNum/10   % 10;
    Seg2 <= iNum/100  % 10;
    Seg3 <= iNum/1000 % 10;
end

sevensegmentcontroller s0 (
    .iClk(iClk_50),
    .nRst(nRst),
    .iNum(Seg0),
    .eBlink(eBlink),
    .oSeg(HEX0)
);

sevensegmentcontroller s1 (
    .iClk(iClk_50),
    .nRst(nRst),
    .iNum(Seg1),
    .eBlink(eBlink),
    .oSeg(HEX1)
);

sevensegmentcontroller s2 (
    .iClk(iClk_50),
    .nRst(nRst),
    .iNum(Seg2),
    .eBlink(eBlink),
    .oSeg(HEX2)
);

sevensegmentcontroller s3 (
    .iClk(iClk_50),
    .nRst(nRst),
    .iNum(Seg3),
    .eBlink(eBlink),
    .oSeg(HEX3)
);
    
endmodule