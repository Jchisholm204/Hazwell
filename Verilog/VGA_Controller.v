module VGA_Controller (
    // VGA Clock (~25Mhz)
    iClk_25,
    // Module Reset
    nRst,

    // Input RGB Color Signals
    iRed,
    iGreen,
    iBlue,

    // VGA Cordinate Outputs
    oCurrX,
    oCurrY,

    // VGA DAC Outputs
    oVGA_R,
    oVGA_G,
    oVGA_B,
    oVGA_HS,
    oVGA_VS,
    oVGA_SYNC,
    oVGA_BLANK
);

input             iClk_25;
input             nRst;
input       [9:0] iRed;
input       [9:0] iGreen;
input       [9:0] iBlue;
output      [9:0] oCurrX;
output      [9:0] oCurrY;
output      [9:0] oVGA_R;
output      [9:0] oVGA_G;
output      [9:0] oVGA_B;
output reg        oVGA_HS;
output reg        oVGA_VS;
output            oVGA_SYNC;
output            oVGA_BLANK;

assign oVGA_SYNC   = 1'b1;
assign oVGA_BLANK  = oVGA_HS & oVGA_VS;

parameter H_ACT    = 640;
parameter H_FRONT  = 16;
parameter H_SYNC   = 96;
parameter H_BACK   = 48;
parameter V_ACT    = 480;
parameter V_FRONT  = 10;
parameter V_SYNC   = 2;
parameter V_BACK   = 33;

endmodule