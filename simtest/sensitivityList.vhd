library ieee;
entity sensitivityList is
end entity;

architecture sim of sensitivityList is
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
      if countUp = countDown then report "Process A: JackPot"; end if;
      wait on countUp, countDown;
  end process;
  
  process(countUp, countDown) is
    begin
      if countUp = countDown then report "Process B: Jackpot"; end if;
  end process;
  
end architecture;

