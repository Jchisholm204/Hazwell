library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debounce is
  port(
    i_clk    : in  std_logic;
    i_button : in  std_logic;
    o_button : out std_logic
  );
end entity;

architecture behavioral of debounce is
  signal count : integer := 0;
  signal button_last : std_logic;
begin
  process(i_clk) is
    begin
      if(button_last /= i_button) then
        count <= 0;
      else
        count <= count + 1;
        if(count = 8) then
          o_button <= i_button;
        else
        end if;
      end if;
      button_last <= i_button;

  end process;
end architecture;

    
    
