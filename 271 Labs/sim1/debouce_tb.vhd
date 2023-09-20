library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debounce_tb is
end entity;

architecture sim of debounce_tb is
  signal count : integer := 0;
  signal i_button : std_logic := '0';
  signal o_button : std_logic;
  signal clk : std_logic := '0';
begin
    db : entity work.debounce(behavioral)
    port map(
        i_clk => clk,
        o_button => o_button,
        i_button => i_button
    );
    
  clk <= not clk after 1 ns;
    
  process is
    begin
      wait until rising_edge(clk);
      wait until rising_edge(clk);
      wait until rising_edge(clk);
      wait until rising_edge(clk);
      i_button <= '1';
      wait for 20 ns;
      i_button <= '0';
      wait for 3 ns;
      i_button <= '1';
      wait for 2 ns;
      i_button <= '0';
      wait for 20 ns;
  end process;
end architecture;

    
    


