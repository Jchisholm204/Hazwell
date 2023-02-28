library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity segmentTb is
end entity;

architecture sim of segmentTb is
  
  -- dip switch inputs
  signal Switches : std_logic_vector(7 downto 0) := (others => '0');
  signal number   : unsigned(7 downto 0)         := (others => '0');
  
  signal Seg1     : unsigned(3 downto 0) := (others => 'X');
  signal Seg2     : unsigned(3 downto 0) := (others => 'X');
  
  
begin

  process(number) is
  begin
    Seg1 <= number mod 10;
    Seg2 <= number mod 1;
  end process;
  
  process is
  begin
    wait for 10 ns;
    Switches <= "00000001";
    wait for 10 ns;
    Switches <= "00000010";
    wait for 10 ns;
    Switches <= "00000011";
    wait for 10 ns;
    Switches <= "00000100";
    wait for 10 ns;
    Switches <= "00000101";
    wait for 10 ns;
    Switches <= "00000110";
    wait for 10 ns;
    Switches <= "00000111";
    wait for 10 ns;
    Switches <= "00001000";
    wait for 10 ns;
    Switches <= "00010000";
    wait for 10 ns;
    Switches <= "00010100";
    wait;
  end process;
  
  number <= unsigned(Switches);
    
end architecture;





