library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is
    port(

    -- HEX Segments
        HEX0         : out std_logic_vector(6 downto 0);
        HEX1         : out std_logic_vector(6 downto 0);
        HEX2         : out std_logic_vector(6 downto 0);
        HEX3         : out std_logic_vector(6 downto 0);
        HEX4         : out std_logic_vector(6 downto 0);
        HEX5         : out std_logic_vector(6 downto 0);
        HEX6         : out std_logic_vector(6 downto 0);
        HEX7         : out std_logic_vector(6 downto 0);
        
		
        -- Clock Input (50 MHz)
		CLOCK_50     : in  std_logic;

        LEDR         : out std_logic_vector(7 downto 0);

        PS2_CLK      : in std_logic;
        PS2_DAT      : in std_logic

    );
end entity;

architecture rtl of top is

    signal PS2_REG      : unsigned(10 downto 0);
    signal PS2_CODE     : std_logic_vector(7 downto 0);
    signal code_num     : integer;

begin

    HEX3 <= (others => '1');
    HEX4 <= (others => '1');
    HEX5 <= (others => '1');
    HEX6 <= (others => '1');
    HEX7 <= (others => '1');

    seg7: entity work.sevensegments(behavioral)
        port map(
            i_dispNum => code_num,
            o_dispSeg1 => HEX0,
            o_dispSeg2 => HEX1,
            o_dispSeg3 => HEX2
        );

    keyboard : entity work.ps2_keyboard(logic)
    port map(
        clk => CLOCK_50,
        ps2_clk => PS2_CLK,
        ps2_data => PS2_DAT,
        ps2_code => PS2_CODE
    );

    LEDR     <= PS2_CODE;
    code_num <= to_integer(unsigned(PS2_CODE));

end architecture;