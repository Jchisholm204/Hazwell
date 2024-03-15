module LCD_Controller(
    iClk, nRst,
    iStart, oDone,
    iData, iRS, // Data Input / H:Data/L:Instruction Code
    LCD_DATA,
    LCD_RS, LCD_RW, LCD_En
);

input wire iClk, nRst, iStart, iRS;
input wire [7:0] iData;
output wire [7:0] LCD_DATA;
output wire LCD_RS, LCD_RW;
output reg oDone, LCD_En;

assign LCD_RS = iRS;
assign LCD_RW = 1'b0;
assign LCD_DATA = iData;

parameter ClkDiv = 16;

reg [1:0] Start = 2'd0;
reg [1:0] State = 2'd0;
reg [4:0] Count = 5'd0;

always@(posedge iClk or negedge nRst)
begin
    if(!nRst) begin
        oDone  <= 1'b0;
        LCD_En <= 0;
        Start <= 2'd0;
    end
    else begin
        Start <= {Start[0], iStart};
        if(Start == 2'b01) begin
            State <= 2'b01;
            oDone <= 1'b0;
        end
        case(State)
        1: begin
            LCD_En <= 1'b1;
            State  <= 1'b10;
        end
        2: begin
            if(Count < ClkDiv) Count <= Count + 5'd1;
            else State <= 1'b11;
        end
        3: begin
            LCD_En <= 1'b0;
            Count <= 5'd0;
            oDone <= 1'b1;
            State <= 2'b00;
        end
        endcase
    end
end

endmodule