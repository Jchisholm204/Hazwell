library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock is
    generic ( ClkFreq : integer);
    port(
        nRst       : in    std_logic;
        Clk        : in    std_logic;
        Millis     : inout integer;
        Seconds    : inout integer
    );
end entity clock;

architecture rtl of clock is
    
    signal Ticks : integer;

begin
    
    process( Clk ) is
        begin

            if rising_edge( Clk ) then
                if nRst = '0' then
                    Ticks   <= 0;
                    Millis  <= 0;
                    Seconds <= 0;
                else
                    if (Ticks) = ((ClkFreq/1000)- 1) then
                        Ticks <= 0;

                        if Millis = 999 then
                            Millis <= 0;

                            if Seconds = 59 then
                                Seconds <= 0;
                            else
                                Seconds <= Seconds + 1;
                            end if;
                        else
                            Millis <= Millis + 1;
                        end if;
                    else
                        Ticks <= Ticks + 1;
                    end if;
                end if;
            end if;
    end process;
    
end architecture rtl;