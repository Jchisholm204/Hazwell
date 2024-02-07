library verilog;
use verilog.vl_types.all;
entity ADDER is
    generic(
        N               : integer := 16
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        Cin             : in     vl_logic;
        s               : out    vl_logic_vector;
        Cout            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end ADDER;
