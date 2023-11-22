library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is

end entity;

architecture sim of top_tb is
    signal colorr       : std_logic_vector(9 downto 0);
    signal colorg       : std_logic_vector(9 downto 0);
    signal colorb       : std_logic_vector(9 downto 0);
    signal VGA_CLK      : std_logic;
    signal VGA_BLANK    : std_logic;
    signal VGA_HS       : std_logic;
    signal VGA_VS       : std_logic;
    signal VGA_SYNC     : std_logic;
    signal CLOCK_50     : std_logic := '0';
    signal LEDG0, LEDG1 : std_logic;
begin

    tb : entity work.top(rtl)
        port map(
            VGA_R => colorr,
            VGA_B => colorb,
            VGA_G => colorg,
            VGA_CLK => VGA_CLK,
            VGA_BLANK => VGA_BLANK,
            VGA_HS => VGA_HS,
            VGA_VS => VGA_VS,
            VGA_SYNC => VGA_SYNC,
            CLOCK_50 => CLOCK_50,
            LEDG0 => LEDG0,
            LEDG1 => LEDG1
        );

    CLOCK_50 <= not CLOCK_50 after 1000 ms /100e6;

end architecture;
