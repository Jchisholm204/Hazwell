library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        OP              : in     vl_logic_vector(5 downto 0);
        oZero           : out    vl_logic;
        oNeg            : out    vl_logic;
        iRA             : in     vl_logic_vector(31 downto 0);
        iRB             : in     vl_logic_vector(31 downto 0);
        oRC             : out    vl_logic_vector(31 downto 0)
    );
end ALU;
