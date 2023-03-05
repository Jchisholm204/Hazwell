library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity timerTb is
end entity;

architecture sim of timerTb is

    --constant ClockFrequency : integer := 100e6; -- 100MHz
    constant ClockFrequency : integer := 10; -- 10Hz
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

    signal Clk  : std_logic := '1';
    signal nRst : std_logic := '0';

    signal Seconds : integer;
    signal Minutes : integer;
    signal Hour    : integer;
  
begin
    -- Process generating Clock signal
    Clk <= not Clk after ClockPeriod/2;


    i_Timer : entity work.timer(rtl)
    generic map(ClockFrequency => ClockFrequency)
    port map(
        Clk => Clk,
        nRst => nRst,
        Seconds => Seconds,
        Minutes => Minutes,
        Hours => Hour
    );

    -- Test process
    process is
    begin
        wait until rising_edge(Clk);
        wait until rising_edge(Clk);
        nRst <= '1';
        wait;

    end process;
    
end architecture;






