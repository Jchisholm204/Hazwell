library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity portmapTB is
end entity;

architecture sim of portmapTB is
  
  signal Sig1 : unsigned(7 downto 0) := x"AA";
  signal Sig2 : unsigned(7 downto 0) := x"BB";
  signal Sig3 : unsigned(7 downto 0) := x"CC";
  signal Sig4 : unsigned(7 downto 0) := x"DD";
  
  signal Sel : unsigned(1 downto 0) := (others => '0');
  
  signal Output : unsigned(7 downto 0);
  
begin
  
  -- An instance of mux with architecture rtl
  i_Mux1 : entity work.mux(rtl) port map (
    Sel    => Sel,
    Sig1   => Sig1,
    Sig2   => Sig2,
    Sig3   => Sig3,
    Sig4   => Sig4,
    Output => Output);
  
  -- Testbench process
  process is
  begin
    wait for 10 ns;
    Sel <= Sel + 1;
    wait for 10 ns;
    Sel <= Sel + 1;
    wait for 10 ns;
    Sel <= Sel + 1;
    wait for 10 ns;
    Sel <= Sel + 1;
    wait for 10 ns;
    Sel <= (others => 'U');
    wait;
    
  end process;
  
    
end architecture;






