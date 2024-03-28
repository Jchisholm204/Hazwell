library verilog;
use verilog.vl_types.all;
entity control is
    generic(
        C_Select_RA     : vl_logic_vector(1 downto 0) := (Hi1, Hi0)
    );
    port(
        iOP             : in     vl_logic_vector(16 downto 0);
        iRdy            : in     vl_logic;
        PC_en           : out    vl_logic;
        PCT_en          : out    vl_logic;
        IR_en           : out    vl_logic;
        MDR_en          : out    vl_logic;
        MAR_en          : out    vl_logic;
        MOR_en          : out    vl_logic;
        RF_Write        : out    vl_logic;
        ALU_op          : out    vl_logic_vector(5 downto 0);
        MAR_Select      : out    vl_logic;
        ALUB_Select     : out    vl_logic;
        PCA_Select      : out    vl_logic;
        PC_Select       : out    vl_logic_vector(1 downto 0);
        C_Select        : out    vl_logic_vector(1 downto 0);
        AddrC_Select    : out    vl_logic_vector(1 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of C_Select_RA : constant is 2;
end control;
