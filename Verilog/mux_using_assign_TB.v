
`timescale 1ps/1ps

module mux_using_assign_TB;
    
    reg din_0, din_1, sel;
    wire mux_out;
    mux_using_assign mua (din_0, din_1, sel, mux_out);
    initial begin
        din_0 = 1;
        din_1 = 0;
        sel   = 0;
    end

    always #5 sel = ~sel;

endmodule