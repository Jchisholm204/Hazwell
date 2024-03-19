`timescale 1ns/1ns

module test_tb();

reg CLK;

initial begin
    forever begin
        CLK = 1'b0;
        #1;
        CLK = 1'b1;
        #1;
    end
end
endmodule
