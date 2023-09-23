library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debounce_tb is
end entity;

architecture sim of debounce_tb is
  signal i_button : std_logic := '0';
  signal o_button : std_logic;
  signal clk : std_logic := '0';

  constant ClockFrequency : integer := 50e2; -- 100MHz
  constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

begin
    db : entity work.debounce(behavioral)
    generic map(
      clkFreq => ClockFrequency
    )
    port map(
        i_clk => clk,
        o_button => o_button,
        i_button => i_button
    );
    
  clk <= not clk after ClockPeriod/2;
    
  process is
    begin
      i_button <= '1';
      wait for 15 ms;
      i_button <= '0';
      wait for 15 ms;
  end process;
end architecture;

    
    


