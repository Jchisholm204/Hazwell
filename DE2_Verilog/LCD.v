module LCD(
    iClk, nRst,
    iStart, oDone,
    iData, iRS
    LCD_DATA,
    LCD_RS, LCD_RW, LCD_En
)

input wire iClk, nRst, iStart, iRS;
input wire [7:0] iData;
inout wire [7:0] LCD_DATA;
output wire oDone, LCD_RS, LCD_RW, LCD_En;

assign LCD_RS = iRS;
assign LCD_RW = 1'b0;

parameter ClkDiv = 16;

reg [1:0] init = 2'd0;
reg [4:0] Count = 5'd0;

always@(posedge iClk or negedge nRst)
begin
    if(!nRst) begin
        oDone  <= 1'b0;
        LCD_RS <= 0;
        LCD_RW <= 0;
        LCD_En <= 0;
        LCD_DATA <= 0;
    end
    else begin
        if(init[0])

end

endmodule