library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clockTB is
end entity;

architecture simulator of clockTB is
    
    constant ClkFreq        : integer := 10000;
    constant ClockPeriod    : time    := 1000 ms / ClkFreq;

    signal nRst      : std_logic := '0';
    signal Millis    : integer;
    signal Seconds   : integer;
    signal Clk       : std_logic := '0';

begin
    
    Clk <= not Clk after ClockPeriod/2;

    i_clock : entity work.clock(rtl)
    generic map( ClkFreq => ClkFreq )
    port map(
        nRst    => nRst,
        Clk     => Clk,
        Millis  => Millis,
        Seconds => Seconds
    );

    process is
        begin
            wait until rising_edge(Clk);
            wait until rising_edge(Clk);
            nRst <= '1';
    end process;

    
end architecture simulator;