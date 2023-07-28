module vga_640x480 (
        CLK_50,
        CLK_25,
        nRst,
        VGA_CLK,
        VGA_BLANK,
        VGA_SYNC,
        VGA_HS,
        VGA_VS,
        VGA_R,
        VGA_G,
        VGA_B,
        iRed,
        iGreen,
        iBlue,
        oX,
        oY,
        oImValid
    );

input  wire CLK_50, CLK_25;
input  wire nRst;
output wire VGA_CLK;
output wire VGA_BLANK;
output wire VGA_SYNC;
output wire VGA_HS;
output wire VGA_VS;
output wire [9:0] VGA_R, VGA_G, VGA_B;
input  wire [9:0] iRed, iGreen, iBlue;
output wire  [31:0] oX, oY;
output wire oImValid;

reg [31:0] imX, imY;

assign VGA_HS   = ((imX < 32'd656) || (imX > 32'd752));
assign VGA_VS   = ((imY < 32'd490) || (imY > 32'd492));
assign oImValid = ((imX < 32'd640) && (imY < 32'd480)) ? 1'b1 : 1'b0;
assign oX       = oImValid ? imX : 32'd640;
assign oY       = oImValid ? imY : 32'd480;
assign VGA_SYNC = 1'b1;
assign VGA_BLANK = ((VGA_VS) && (VGA_HS));
assign VGA_CLK = CLK_25;

assign VGA_R = (oImValid == 1'b1) ? iRed   : 10'd0;
assign VGA_G = (oImValid == 1'b1) ? iGreen : 10'd0;
assign VGA_B = (oImValid == 1'b1) ? iBlue  : 10'd0;

always @(posedge CLK_25 or negedge nRst) begin
    if(nRst == 1'b0) begin
        imX <= 32'd0;
        imY <= 32'd0;
    end else begin
        if(imX <= 32'd800) begin
            imX <= imX + 32'd1;
        end else begin
            imX <= 32'd0;
            if(imY <= 525) begin
                imY <= imY + 32'd1;
            end else begin
                imY <= 32'd0;
            end
        end
    end
end

endmodule