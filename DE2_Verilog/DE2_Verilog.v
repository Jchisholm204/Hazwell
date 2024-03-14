module DE2_Verilog(
    CLOCK_50,
    KEY, SW,
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
    LEDG, LEDR
);

input wire CLOCK_50;
input wire [17:0] SW;
input wire [3:0]  KEY;
output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
output wire [8:0] LEDG;
output wire [17:0] LEDR;

reg [8:0] Wrapper = 9'b1;

assign LEDG = Wrapper;

reg [31:0] Count  = 32'd0;
reg [31:0] ClkDiv = 32'd0;

assign LEDR = SW;

always @(posedge CLOCK_50) begin
    if(!SW[0]) begin
        Count = 32'd0;
        ClkDiv = 32'd0;
		  Wrapper = 9'd0;
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


endmodule
