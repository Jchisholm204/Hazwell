library verilog;
use verilog.vl_types.all;
entity REG32 is
    port(
        iClk            : in     vl_logic;
        nRst            : in     vl_logic;
        iEn             : in     vl_logic;
        iD              : in     vl_logic_vector(31 downto 0);
        oQ              : out    vl_logic_vector(31 downto 0)
    );
end REG32;
