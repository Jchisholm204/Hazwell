library verilog;
use verilog.vl_types.all;
entity proc is
    port(
        iClk            : in     vl_logic;
        nRst            : in     vl_logic;
        iRdy            : in     vl_logic;
        oMemAddr        : out    vl_logic_vector(31 downto 0);
        iMemData        : in     vl_logic_vector(31 downto 0);
        oMemData        : out    vl_logic_vector(31 downto 0);
        oMemWrite       : out    vl_logic;
        oMemRead        : out    vl_logic
    );
end proc;
