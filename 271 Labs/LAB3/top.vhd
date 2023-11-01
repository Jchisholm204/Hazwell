library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        signal i_CLK  : IN  std_logic;
        signal i_SW   : IN  std_logic_vector(7 downto 0);
        signal i_KEY  : IN  std_logic_vector(3 downto 0);
        signal o_LEDR : OUT std_logic_vector(7 downto 0);
        signal o_LEDG : OUT std_logic_vector(3 downto 0);
        signal o_HEX0 : OUT std_logic_vector(7 downto 0);
        signal o_HEX1 : OUT std_logic_vector(7 downto 0);
    );
end entity;

architecture rtl of top is
    signal data : std_logic_vector(7 downto 0);
begin

    LUT : entity work.lut8(behavioral)
        port map(
            i_clk => i_CLK,
            i_select => i_SW(2 downto 0),
            o_out => data(0)
        );

    DRIVER : entity work.Eight_Seg_Display_Out(Behavior)
        port map(
            clk => i_CLK,
            data => data,
            output1 => o_HEX0,
            output2 => o_HEX1
        );

    data(7 downto 1) <= (others => '0');
   
    
end architecture; -- arch
