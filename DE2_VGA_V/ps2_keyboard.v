module ps2_keyboard (
    nRst,
    ps2_clk,
    ps2_data,
    code_ready,
    ps2_code
);

input  wire       nRst,
input  wire       ps2_data,
output reg        code_ready,
output reg [7:0]  ps2_code;

reg [10:0] data_register;
reg [7:0] clkCount;

always @(negedge ps2_clk or negedge nRst) begin
    if(nRst == 1'b0) begin
        data_register <= 10'd0;
        clkCount      <= 8'd0;
        code_ready    <= 1'b0;
        ps2_code      <= 8'd0;
    end else begin
        data_register <= ps2_data & data_register[10:1];
        clkCount <= clkCount + 8'd1;
        if(clkCount == 8'd10) begin
            code_ready <= 1'b1;
            ps2_code   <= data_register[8:1];
            clkCount   <= 8'd0;
        end else begin
            code_ready <= 1'b0;
        end
    end
end
    
endmodule