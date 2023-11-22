library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock is
    generic(ClkFreq : integer);
    port(
        Clk     : in    std_logic;
        nRst    : in    std_logic;
        Millis  : inout integer;
        Seconds : inout integer;
        Minutes : inout integer;
        Hours   : inout integer
    );
end entity;

architecture rtl of clock is
    signal Ticks : integer := 0;
begin

    process(Clk) is
    begin
        if rising_edge(Clk) then
            if nRst = '0' then
                Ticks    <= 0;
                Millis   <= 0;
                Seconds  <= 0;
                Minutes  <= 0;
                Hours    <= 0;
            else
                if Ticks = (ClkFreq * 10e-3) - 1 then
                    Ticks <= 0;
                    if Millis = 1000 then
                        Millis <= 0;
                        if Seconds = 60 then
                            Seconds <= 0;
                            if Minutes = 60 then
                                Minutes <= 0;
                                if Hours = 23 then
                                    Hours <= 0;
                                else
                                    Hours <= Hours +1;
                                end if;
                            else
                                Minutes <= Minutes +1;
                            end if;
                        else
                            Seconds <= Seconds + 1;
                        end if;
                    else
                        Millis <= Millis + 1;
                    end if;
                else:
                    Ticks <= Ticks + 1;
                end if;
            end if;
        end if;
    end process;

end architecture;
