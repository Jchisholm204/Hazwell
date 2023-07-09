module adder (
);

`timescale 1ns/1ns

wire clock = 1'b0;

wire [3:0] c, d;
wire [4:0] sum;

assign c = 4'b0001;
assign d = -4'b0001; // = 4'b1111

assign sum = {c[3], c} + {d[3], d};

endmodule