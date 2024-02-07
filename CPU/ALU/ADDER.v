module ADDER #(parameter N=16)(
    a, b, Cin,
    s, Cout
);

input  wire [N - 1:0] a, b;
input  wire           Cin;
output wire           Cout;
output wire  [N - 1:0] s;

wire [N -1:0] s_aux;
wire [N -1:0] gen, prop, carry;

assign s_aux = a ^ b;
assign gen   = a & b;
assign prop  = a | b;


assign carry[1] = gen[0] | (prop[0] & Cin);

genvar i;
generate
    for (i = 0; i < N-1; i = i + 1) begin
        assign carry[i +1] = gen[i] | (prop[i] & carry[i]);
    end
endgenerate

assign Cout = gen[N -1] | (prop[N -1] & carry[N -1]);
assign s[0] = s_aux[0] ^ Cin;
assign s[N -1:1] = s_aux[N -1:1] ^ carry[N -1:1];

endmodule
