library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity topTB2 is
end entity;


architecture sim of topTB2 is
    signal HEX0  :  std_logic_vector(6 downto 0);
    signal HEX1  :  std_logic_vector(6 downto 0);
    signal HEX2  :  std_logic_vector(6 downto 0);

    signal KEY0  :  std_logic := '0';
    signal KEY3  :  std_logic := '0';

    signal SW    :  std_logic_vector(2 downto 0) := (others => '0');

    signal Clk   :  std_logic := '0';

    constant ClkFreq        : integer := 10000;
    constant ClockPeriod    : time    := 1000 ms / ClkFreq;
    
begin
    
    Clk <= not Clk after ClockPeriod/2;

    SW <= "001";

    i_top : entity work.top(rtl)
    port map(
        o_HEX0 => HEX0,
        o_HEX1 => HEX1,
        o_HEX2 => HEX2,
        i_KEY0 => KEY0,
        i_KEY3 => KEY3,
        i_SW   => SW,
        i_Clk  => Clk
    );

    process is
    begin
        wait for 200 ms;
        KEY3 <= '1';
        wait for 200 ms;
        KEY3 <= '0';
        wait for 800 ms;
        wait for 200 ms;
        KEY3 <= '1';
        wait for 200 ms;
        KEY3 <= '0';
        wait;
    end process;
    
    
end architecture sim;