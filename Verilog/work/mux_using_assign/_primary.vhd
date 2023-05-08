library verilog;
use verilog.vl_types.all;
entity mux_using_assign is
    port(
        din_0           : in     vl_logic;
        din_1           : in     vl_logic;
        sel             : in     vl_logic;
        mux_out         : out    vl_logic
    );
end mux_using_assign;
