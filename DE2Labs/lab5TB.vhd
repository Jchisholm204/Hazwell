library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lab5TB is
end entity lab5TB;

architecture simulator of lab5TB is
    
    signal HEX0 : std_logic_vector(6 downto 0);
    signal HEX1 : std_logic_vector(6 downto 0);
    signal HEX2 : std_logic_vector(6 downto 0);

    signal KEY0 : std_logic := '0';
    signal KEY3 : std_logic := '0';

    signal SW   : std_logic_vector(7 downto 0);
    signal Clk  : std_logic := '0';

begin

    i_lab5 : entity work.lab5(rtl)
    port map(
        HEX0 => HEX0,
        HEX1 => HEX1,
        HEX2 => HEX2,
        KEY0 => KEY0,
        KEY3 => KEY3,
        SW   => SW,
        Clk  => Clk
    );

    SW <= "00000010";

    process is
        begin
            KEY3 <= '0';
            wait for 2000 ns;
            wait for 80 ns;
            KEY3 <= '1';
            wait;
    end process;

    process is
        begin
            Clk <= not Clk;
            wait for 100 ns;
    end process;
    
end architecture simulator;