library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is
    generic(
        clk_freq : integer;
    );
    port (
        clk      : in std_logic;
        rst      : in std_logic;
        
    );
end pwm;