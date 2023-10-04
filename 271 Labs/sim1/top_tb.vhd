library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end entity;

architecture sim of top_tb is
  signal button  : std_logic_vector(3 downto 0) := (others => '0');
  signal keys    : std_logic_vector(7 downto 0) := (others => '0');
  signal ledr    : std_logic_vector(7 downto 0) := (others => '0');
  signal ledg    : std_logic_vector(3 downto 0) := (others => '0');
  signal clk : std_logic := '0';

  constant ClockFrequency : integer := 50e3; -- 100MHz
  constant ClockPeriod    : time    := 1000 ms / ClockFrequency;

begin
    top : entity work.top(rtl)
    port map(
        i_CLK => clk,
        i_SW => keys,
        i_KEY => button,
        o_LEDR => ledr,
        o_LEDG => ledg
    );
    
  clk <= not clk after ClockPeriod/2;
    
  process is
    begin
        keys <= "00000000";
        button(0) <= '0';
        wait for 15 ms;
        button(0) <= '1';
        wait for 15 ms;
        keys <= "00010000";
        button(1) <= '1';
        wait for 15 ms;
  end process;
end architecture;

    
    


