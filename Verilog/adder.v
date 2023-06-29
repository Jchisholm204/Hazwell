module adder (
);

`timescale 1ns/1ns

wire clock = 1'b0;

wire [3:0] c, d;
wire [4:0] sum;

assign c = 4'd1;
assign d = 4'd3;

assign sum = {c[3], c} + {d[3], d};

endmodule