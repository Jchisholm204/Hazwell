library ieee;
entity ifStatement is
end entity;

architecture sim of ifStatement is
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
      wait until countUp = countDown;
      report "equal";
  end process;
    
  process is
    begin
    if countUp > countDown then
      report "countUp is larger";
    elsif countDown > countUp then
      report "countDown is larger";
    else
      report "The values are equal";
    end if;
    wait on countUp, countDown;
  end process;
    
end architecture;
