module SEG7(
    oSEGMENT, iDIGIT
);

input wire [3:0] iDIGIT;
output reg [6:0] oSEGMENT;

always @(iDIGIT)
begin
    case(iDIGIT)
		4'h1:    oSEGMENT = 7'b1111001;	// ---t----
		4'h2:    oSEGMENT = 7'b0100100; 	// |	  |
		4'h3:    oSEGMENT = 7'b0110000; 	// lt	 rt
		4'h4:    oSEGMENT = 7'b0011001; 	// |	  |
		4'h5:    oSEGMENT = 7'b0010010; 	// ---m----
		4'h6:    oSEGMENT = 7'b0000010; 	// |	  |
		4'h7:    oSEGMENT = 7'b1111000; 	// lb	 rb
		4'h8:    oSEGMENT = 7'b0000000; 	// |	  |
		4'h9:    oSEGMENT = 7'b0011000; 	// ---b----
		4'ha:    oSEGMENT = 7'b0001000;
		4'hb:    oSEGMENT = 7'b0000011;
		4'hc:    oSEGMENT = 7'b1000110;
		4'hd:    oSEGMENT = 7'b0100001;
		4'he:    oSEGMENT = 7'b0000110;
		4'hf:    oSEGMENT = 7'b0001110;
      4'h0:    oSEGMENT = 7'b1000000;
    endcase
end

endmodule