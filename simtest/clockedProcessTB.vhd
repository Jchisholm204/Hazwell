library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity clockedProcessTB is
end entity;

architecture sim of clockedProcessTB is

    constant ClockFrequency : integer := 100e6; -- 100MHz
    constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

    signal nRst : std_logic := '0';
    signal Input : std_logic := '0';
    signal Output : std_logic;

    signal Clk : std_logic := '1';
  
begin

    -- Device under test
    i_FlipFlop : entity work.flipFlop(rtl)
        port map(
            Clk => Clk,
            nRst => nRst,
            Input => Input,
            Output => Output
        );
  
    -- Process generating Clock signal
    Clk <= not Clk after ClockPeriod/2;

    -- Test process
    process is
    begin

        nRst <= '1';
        
        wait for 20 ns;

        Input <= '1';

        wait for 22 ns;

        Input <= '0';

        wait for 6 ns;

        Input <= '1';

        wait for 20 ns;

        nRst <= '0';

        wait;

    end process;
    
end architecture;






