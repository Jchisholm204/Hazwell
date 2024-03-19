library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        iOP             : in     vl_logic_vector(3 downto 0);
        iRegA           : in     vl_logic_vector(31 downto 0);
        iRegB           : in     vl_logic_vector(31 downto 0);
        oRegC           : out    vl_logic_vector(31 downto 0);
        oNEG            : out    vl_logic;
        oZERO           : out    vl_logic
    );
end ALU;
