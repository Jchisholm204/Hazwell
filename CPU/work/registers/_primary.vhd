library verilog;
use verilog.vl_types.all;
entity registers is
    port(
        iClk            : in     vl_logic;
        nRst            : in     vl_logic;
        iWrite          : in     vl_logic;
        iAddrA          : in     vl_logic_vector(4 downto 0);
        iAddrB          : in     vl_logic_vector(4 downto 0);
        iAddrC          : in     vl_logic_vector(4 downto 0);
        oRegA           : out    vl_logic_vector(31 downto 0);
        oRegB           : out    vl_logic_vector(31 downto 0);
        iRegC           : in     vl_logic_vector(31 downto 0)
    );
end registers;
