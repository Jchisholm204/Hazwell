library verilog;
use verilog.vl_types.all;
entity ha is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        sum             : out    vl_logic;
        cout            : out    vl_logic
    );
end ha;
