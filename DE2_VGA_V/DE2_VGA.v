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
        HEX7,
        PS2_CLK,
        PS2_DAT
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
input wire PS2_CLK, PS2_DAT;

wire [7:0] dispNum; //0-255
wire      running;
assign running = SW[0];
reg [31:0]  ClkCount;

reg CLOCK_25 = 1'b0;

reg [9:0]  r, g, b;
reg [31:0] x, y, divend;
wire imValid;

sevensegments segments (
    .iClk_50(CLOCK_50),
    .iNum(ps2_code),
    .eBlink(~ps2_code_ready),
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
    .CLK_50(CLOCK_50),
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
    .iRed(r),
    .iGreen(g),
    .iBlue(b),
    // .oX(x),
    // .oY(y),
    .oImValid(imValid)
);

wire ps2_code_ready;
wire [7:0] ps2_code;
reg [7:0] color_code;

ps2_keyboard keyboard (
    .nRst(1'b1),
    .ps2_clk(PS2_CLK),
    .ps2_data(PS2_DAT),
    .code_ready(ps2_code_ready),
    .ps2_code(ps2_code),
    .clkCount(dispNum)
);

always @( ps2_code_ready ) begin
    if(ps2_code == 8'h2D) color_code <= 8'h2D;
    if(ps2_code == 8'h34) color_code <= 8'h34;
    if(ps2_code == 8'h32) color_code <= 8'h32;

    if(color_code == 8'h2D) begin
        if(ps2_code == 8'h16) r <= 10'd800;
        if(ps2_code == 8'h0E) r <= 10'd0;
    end
end

always @(posedge CLOCK_50) 
    CLOCK_25 <= ~CLOCK_25;

// always @(posedge CLOCK_50  or negedge running) begin
//     if (running == 1'b0) begin
//         ClkCount <= 32'd0;
//         dispNum  <= 8'd0;
//     end
//     else begin
//         ClkCount <= ClkCount + 1;
//         if (ClkCount == 32'd1_000_000) begin
//             ClkCount <= 1'd0;
//             dispNum <= dispNum + 8'd1;
//             divend <= divend + 32'd1;
//             if (divend == 32'd640)
//                 divend <= 32'd0;
//             if (dispNum == 8'd255) begin
//                 dispNum <= 1'd0;
//             end
//         end
//     end
// end

endmodule