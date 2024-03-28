library verilog;
use verilog.vl_types.all;
entity control is
    generic(
        CaS_RA          : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        CaSIR_dest      : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        CS_PCT          : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        CS_MDR          : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        PCS_RA          : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        PCS_Call        : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        MARS_ALU        : vl_logic := Hi0;
        MARS_PC         : vl_logic := Hi1
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
    attribute mti_svvh_generic_type of CaS_RA : constant is 2;
    attribute mti_svvh_generic_type of CaSIR_dest : constant is 2;
    attribute mti_svvh_generic_type of CS_PCT : constant is 2;
    attribute mti_svvh_generic_type of CS_MDR : constant is 2;
    attribute mti_svvh_generic_type of PCS_RA : constant is 2;
    attribute mti_svvh_generic_type of PCS_Call : constant is 2;
    attribute mti_svvh_generic_type of MARS_ALU : constant is 1;
    attribute mti_svvh_generic_type of MARS_PC : constant is 1;
end control;
