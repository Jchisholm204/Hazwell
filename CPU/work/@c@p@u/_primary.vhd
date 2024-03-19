library verilog;
use verilog.vl_types.all;
entity CPU is
    port(
        iClk            : in     vl_logic;
        nRst            : in     vl_logic;
        oMemAddr        : out    vl_logic_vector(31 downto 0);
        oMemData        : out    vl_logic_vector(31 downto 0);
        iMemData        : in     vl_logic_vector(31 downto 0);
        oMemRW          : out    vl_logic;
        oMemEn          : out    vl_logic
    );
end CPU;
