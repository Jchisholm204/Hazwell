`timescale 1ms/1ps


module clockedProcess();
parameter ClockPeriod = 1000/50e6;
reg clk = 1'b0;

always #(ClockPeriod/2) clk = ~ clk;

endmodule