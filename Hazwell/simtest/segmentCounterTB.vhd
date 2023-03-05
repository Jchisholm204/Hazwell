library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity segmentCounterTB is
end entity;

architecture sim of segmentCounterTB is

    constant ClockFrequency : integer := 50e6; -- 100MHz
    --constant ClockFrequency : integer := 10; -- 10Hz
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

    signal Clk  : std_logic := '1';
    signal nRst : std_logic := '0';

    signal Seg1 : std_logic_vector(6 downto 0);
    signal Seg2 : std_logic_vector(6 downto 0);
    signal Seg3 : std_logic_vector(6 downto 0);
  
begin
    -- Process generating Clock signal
    Clk <= not Clk after ClockPeriod/2;


    i_segmentCounter : entity work.segmentCounter(rtl)
    port map(
        nRst => nRst,
        Clk => Clk,
        DispSeg1 => Seg1,
        DispSeg2 => Seg2,
        DispSeg3 => Seg3
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