
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftRegTB is
  port (
    CLOCK_50    : in std_logic;
    PS2_CLK     : in std_logic;
    PS2_DAT     : in std_logic;
    LEDR        : in std_logic_vector(10 downto 0);
  );
end shiftRegTB;

architecture sim of shiftRegTB is

    signal 

begin

end sim ; -- shiftRegTB