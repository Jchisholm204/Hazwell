module DE2_Verilog(
    CLOCK_50,
    KEY, SW,
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
    LEDG, LEDR,
    LCD_DATA, LCD_ON, LCD_BLON, LCD_RS, LCD_EN, LCD_RW
);

input wire CLOCK_50;
input wire [17:0] SW;
input wire [3:0]  KEY;
output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
output wire [8:0] LEDG;
output wire [17:0] LEDR;

output wire [7:0] LCD_DATA;
output wire LCD_ON, LCD_BLON, LCD_RS, LCD_EN, LCD_RW;

reg [7:0] Wrapper = 8'b1;

assign LEDG[7:0] = Wrapper;
assign LEDG[8] = 1'b0;

reg [31:0] Count  = 32'd0;
reg [31:0] ClkDiv = 32'd0;
wire DEL_RST;

assign LEDR = SW;

assign LCD_ON = 1'b1;
assign LCD_BLON = SW[1];

always @(posedge CLOCK_50) begin
    if(!SW[0]) begin
        Count = 32'd0;
        ClkDiv = 32'd0;
		Wrapper = 8'd1;
    end
    else
        ClkDiv = ClkDiv + 1;
    if(ClkDiv == 32'd50000000) begin
        Count = Count + 32'd1;
        ClkDiv = 32'd0;
		  Wrapper[7:0] = {Wrapper[6:0], Wrapper[7]};
    end
    if(Count == 32'h10) Count = 32'd0;
end

SEG7 u0(
    .oSEGMENT(HEX0),
    .iDIGIT(Count[3:0])
);

SEG7 u1(
	.oSEGMENT(HEX1),
	.iDIGIT(4'hf)
);

LCD_TEST u2(
    .iCLK(CLOCK_50),
    .iRST_N(DLY_RST),
    .LCD_DATA(LCD_DATA),
    .LCD_RW(LCD_RW),
    .LCD_EN(LCD_EN),
    .LCD_RS(LCD_RS)
);

Reset_Delay	r0(
    .iCLK(CLOCK_50),
    .oRESET(DLY_RST)
);

endmodule
