library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        signal i_CLK  : IN  std_logic;
        signal i_SW   : IN  std_logic_vector(17 downto 0);
        signal i_KEY  : IN  std_logic_vector(3 downto 0);
        signal o_LEDR : OUT std_logic_vector(17 downto 0);
        signal o_LEDG : OUT std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of top is
    signal button_o : std_logic;
begin

    -- debouncer entity
    DB : entity work.debounce(behavioral)
			generic map(
            clkFreq => 50e6
        )
        port map(
            i_clk => i_CLK,
            i_button => not i_KEY(0),
            o_button => button_o
        );
		
    LAB : entity work.lab4_traffic(rtl)
        port map(
            button_in => button_o,
            reset => i_SW(0),
            Light1_Green   => o_LEDR(9),
            Light1_Yellow  => o_LEDR(8),
            Light1_Red     => o_LEDR(7),
            Light2_Green   => o_LEDR(6),
            Light2_Yellow  => o_LEDR(5),
            Light2_Red     => o_LEDR(4),
            Light3_Green   => o_LEDR(3),
            Light3_Yellow  => o_LEDR(2),
            Light3_Red     => o_LEDR(1)
        );
    
end architecture; -- arch
