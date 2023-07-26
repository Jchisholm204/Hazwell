module DE2_VGA (
        CLOCK_50,
        SW,
        VGA_R,
        VGA_G,
        VGA_B,
        VGA_CLK,
        VGA_BLANK,
        VGA_HS,
        VGA_VS,
        VGA_SYNC,
        HEX0,
        HEX1,
        HEX2,
        HEX3,
        HEX4,
        HEX5,
        HEX6,
        HEX7
    );

input wire CLOCK_50;
input wire [17:0] SW;
output wire [9:0] VGA_R, VGA_G, VGA_B;
output wire VGA_CLK;
output wire VGA_BLANK;
output wire VGA_HS;
output wire VGA_VS;
output wire VGA_SYNC;
output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;


reg [7:0] dispNum; //0-255
wire      running;
assign running = SW[0];
reg [31:0]  ClkCount;

reg CLOCK_25 = 1'b0;

reg [9:0]  r, g, b;
reg [31:0] x, y;
wire imValid;

sevensegments segments (
    .iClk_50(CLOCK_50),
    .iNum(dispNum),
    .eBlink(~running),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5),
    .HEX6(HEX6),
    .HEX7(HEX7)
);

vga_640x480 vgaController (
    .CLK_25(CLOCK_25),
    .nRst(1'b1),
    .VGA_CLK(VGA_CLK),
    .VGA_BLANK(VGA_BLANK),
    .VGA_SYNC(VGA_SYNC),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .VGA_R(VGA_R),
    .VGA_G(VGA_G),
    .VGA_B(VGA_B),
    .iRed(10'd512),
    .iGreen(10'd512),
    .iBlue(10'd512),
    .oX(x),
    .oY(y),
    .oImValid(imValid)
);

always @(posedge CLOCK_50) 
    CLOCK_25 <= ~CLOCK_25;

always @(posedge CLOCK_50  or negedge running) begin
    if (running == 1'b0) begin
        ClkCount <= 32'd0;
        dispNum  <= 8'd0;
    end
    else begin
        ClkCount <= ClkCount + 1;
        if (ClkCount == 32'd25_000_000) begin
            ClkCount <= 1'd0;
            dispNum <= dispNum + 1'd1;
            if (dispNum == 8'd255) begin
                dispNum <= 1'd0;
            end
        end
    end
end

endmodule