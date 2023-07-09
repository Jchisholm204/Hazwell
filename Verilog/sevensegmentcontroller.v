module segment #(
    parameter blinkDuration = 25e6;
)(
    iClk,
    nRst,
    iNum,
    eBlink,
    oSeg
)

input  wire       iClk'
input  wire       nRst;
input  wire [3:0] iNum;
input  wire       eBlink;
output reg  [6:0] oSeg;

reg [31:0] blinkCount = 0;

always @(posedge iClk or negedge nRst)
begin
    if(nRst == 1'b0) begin
        oSeg = {7{1'b1}};
    end 
    else begin

        case (iNum)
      		4'h1: oSeg = 7'b1111001;	// ---t----
            4'h2: oSeg = 7'b0100100; 	// |	  |
            4'h3: oSeg = 7'b0110000; 	// lt	 rt
            4'h4: oSeg = 7'b0011001; 	// |	  |
            4'h5: oSeg = 7'b0010010; 	// ---m----
            4'h6: oSeg = 7'b0000010; 	// |	  |
            4'h7: oSeg = 7'b1111000; 	// lb	 rb
            4'h8: oSeg = 7'b0000000; 	// |	  |
            4'h9: oSeg = 7'b0011000; 	// ---b----
            4'ha: oSeg = 7'b0001000;
            4'hb: oSeg = 7'b0000011;
            4'hc: oSeg = 7'b1000110;
            4'hd: oSeg = 7'b0100001;
            4'he: oSeg = 7'b0000110;
            4'hf: oSeg = 7'b0001110;
            4'h0: oSeg = 7'b1000000;
        endcase

        if(eBlink == 1'b1) begin
            blinkCount <= blinkCount + 1'd1;
        end else begin
            blinkCount <= 32'd0;
        end
        if(blinkCount == blinkDuration) begin
            oSeg <= ~oSeg;
        end
        
    end
end

endmodule