`timescale  1ms/1ps
module Clock #(
    parameter frequency = 50e6
) (
    nRst,
    oClk
);

parameter clock_period = 1000/frequency;

input wire nRst;
output wire oClk;

reg clock = 1'b0;

assign oClk = clock & nRst;

always @(posedge nRst) begin
    while(nRst == 1'b1) begin
        #(clock_period/2);
        clock = ~clock;
    end
end


endmodule