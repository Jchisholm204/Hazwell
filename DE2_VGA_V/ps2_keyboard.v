module ps2_keyboard (
    nRst,
    ps2_clk,
    ps2_data,
    code_ready,
    ps2_code,
    clkCount
);

input  wire       nRst;
input  wire       ps2_data;
input  wire       ps2_clk;
output wire       code_ready;
output reg [7:0]  ps2_code;

reg [10:0] data_register;
output reg [7:0] clkCount;

assign code_ready = (clkCount == 8'd10);

always @(negedge ps2_clk or negedge nRst) begin
    if(nRst == 1'b0) begin
        data_register <= 10'd0;
        clkCount      <= 8'd0;
        ps2_code      <= 8'd0;
    end else begin
        data_register <= data_register >> 1;
        data_register[10] <= ps2_data;
        clkCount <= clkCount + 8'd1;
        if(clkCount == 8'd10) begin
            ps2_code   <= data_register[9:2];
            clkCount   <= 8'd0;
        end
    end
end
    
endmodule