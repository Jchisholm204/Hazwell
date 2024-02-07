module ADDER_TB();

`define N 16

reg  [`N -1:0] A = 32'd12;
reg  [`N -1:0] B = 32'd4;
wire [`N -1:0] C;
wire overflow;

ADDER #(.N(`N)) testBench(
    .Cin(1'b0),
    .a(A),
    .b(B),
    .s(C),
    .Cout(overflow)
);

endmodule
