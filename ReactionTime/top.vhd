library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
    port(
        o_HEX0  : out std_logic_vector(6 downto 0);
        o_HEX1  : out std_logic_vector(6 downto 0);
        o_HEX2  : out std_logic_vector(6 downto 0);

        i_KEY0  : in  std_logic;
        i_KEY3  : in  std_logic;

        i_SW    : in  std_logic_vector(7 downto 0);

        i_Clk   : in  std_logic
    );

end entity;

architecture rtl of top is
    
    constant ClkFreq  : integer    := 50e6;
    signal   Millis   : integer    := 0;
    signal   Seconds  : integer    := 0;
    signal   running  : std_logic  := '0';
    


begin
    
    
    
end architecture rtl;