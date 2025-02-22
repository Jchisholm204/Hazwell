library ieee;
entity main is
end entity;

architecture sim of main is
  signal countUp   : integer := 0;
  signal countDown : integer := 10;
  
begin

  process is
    begin
      countUp   <= countUp + 1;
      countDown <= countDown - 1;
      wait for 10 ns;
  end process;
  
  process is
    begin
      wait on countUp, countDown;
      report "countUp = " & integer'image(countUp) & " countDown = " & integer'image(countDown);
  end process;
  
  process is
    begin
      wait until countUp = countDown;
      report "equal";
    end process;
    
end architecture;