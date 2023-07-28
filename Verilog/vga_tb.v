`timescale 1ps/1ps

module vga_tb;
    
wire clk;
wire [9:0] VGA_R, VGA_G, VGA_B;
wire VGA_BLANK, VGA_SYNC, VGA_HS, VGA_VS, VGA_CLK;
reg [9:0] r, g, b;
wire [31:0] x, y;
wire imValid;

reg sysnRst;

initial begin
    sysnRst = 1'b0;
    r = 10'd512;
    g = 10'd512;
    b = 10'd512;
    sysnRst = 1'b1; // driven !low to !reset
end

ClockGenerator #(
    .ClockFrequency(25e6)
) c1(
    .nRst(sysnRst),
    .oClk(clk)
);

vga_640x480 vga(
    .CLK_50(clk), // does not matter // for dac only
    .CLK_25(clk),
    .nRst(sysnRst),
    .VGA_CLK(VGA_CLK),
    .VGA_BLANK(VGA_BLANK),
    .VGA_SYNC(VGA_SYNC),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .VGA_R(VGA_R),
    .VGA_G(VGA_G),
    .VGA_B(VGA_B),
    .iRed(10'd511),
    .iGreen(10'd511),
    .iBlue(10'd511),
    .oX(x),
    .oY(y),
    .oImValid(imValid)
);

endmodule