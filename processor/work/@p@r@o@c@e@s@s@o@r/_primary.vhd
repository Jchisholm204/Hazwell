library verilog;
use verilog.vl_types.all;
entity PROCESSOR is
    generic(
        REG_RA          : vl_logic_vector(0 to 4) := (Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        iClk            : in     vl_logic;
        nRst            : in     vl_logic;
        iRDY            : in     vl_logic;
        oMemAddr        : out    vl_logic_vector(31 downto 0);
        oMemData        : out    vl_logic_vector(31 downto 0);
        iMemData        : in     vl_logic_vector(31 downto 0);
        oMemWrite       : out    vl_logic;
        oMemRead        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of REG_RA : constant is 1;
end PROCESSOR;
