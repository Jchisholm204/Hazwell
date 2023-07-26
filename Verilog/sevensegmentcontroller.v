module sevensegmentcontroller #(
    parameter blinkDuration = 32'd25_000_000
)(
    iClk,
    nRst,
    iNum,
    eBlink,
    oSeg
);

input  wire       iClk;
input  wire       nRst;
input  wire [3:0] iNum;
input  wire       eBlink;
output wire  [6:0] oSeg;
reg [6:0] Seg;

reg [31:0] blinkCount = 0;
reg blink = 1'b0;

assign oSeg = blink ? Seg : 7'b1111111;

always @(posedge iClk or negedge nRst)
begin
    // Reset
    if(nRst == 1'b0) begin
        Seg = {7{1'b1}};
		blinkCount <= 0;
    end

    else begin

        // Blink Logic
        if(eBlink == 1'b1) begin
            blinkCount <= blinkCount + 1'b1;
            if(blinkCount == blinkDuration) begin
                blink <= ~blink;
                blinkCount <= 0;
            end
        end else begin
            blink <= 1'b1;
            blinkCount <= 0;
        end

        // Number to 7Segment
        case (iNum)
            4'h1: Seg = 7'b1111001;	// ---t----
            4'h2: Seg = 7'b0100100; 	// |	  |
            4'h3: Seg = 7'b0110000; 	// lt	 rt
            4'h4: Seg = 7'b0011001; 	// |	  |
            4'h5: Seg = 7'b0010010; 	// ---m----
            4'h6: Seg = 7'b0000010; 	// |	  |
            4'h7: Seg = 7'b1111000; 	// lb	 rb
            4'h8: Seg = 7'b0000000; 	// |	  |
            4'h9: Seg = 7'b0011000; 	// ---b----
            4'ha: Seg = 7'b0001000;
            4'hb: Seg = 7'b0000011;
            4'hc: Seg = 7'b1000110;
            4'hd: Seg = 7'b0100001;
            4'he: Seg = 7'b0000110;
            4'hf: Seg = 7'b0001110;
            4'h0: Seg = 7'b1000000;
        endcase
    end
end

endmodule