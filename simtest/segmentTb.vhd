library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity segmentTb is
end entity;

architecture sim of segmentTb is
  
  -- dip switch inputs
  signal Switches : std_logic_vector(7 downto 0) := (others => '0');
  
  signal Seg1     : std_logic_vector(6 downto 0) := (others => 'X');
  signal Seg2     : std_logic_vector(6 downto 0) := (others => 'X');
  signal Seg3     : std_logic_vector(6 downto 0) := (others => 'X');
  
  
begin
  
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
  
    -- An instance of mux with architecture rtl
  i_Segment : entity work.segment(rtl) port map (
    switches   => Switches,
    DispSeg1   => Seg1,
    DispSeg2   => Seg2,
    DispSeg3   => Seg3);
    
end architecture;





