library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity timer is
    generic(ClockFrequency : integer);
    port(
        Clk    : in std_logic;
        nRst   : in std_logic; -- Negative Reset
        Seconds : inout integer;
        Minutes : inout integer;
        Hours   : inout integer
    );
end entity;

architecture rtl of timer is
    signal Ticks : integer;
begin

    process(Clk) is
    begin
        if rising_edge(Clk) then
            if nRst = '0' then
                Ticks   <= 0;
                Seconds <= 0;
                Minutes <= 0;
                Hours   <= 0;
            else

                -- True once every second
                if Ticks = ClockFrequency-1 then
                    Ticks <= 0;
                    
                    -- True once every hour
                    if Seconds = 59 then
                        Seconds <= 0;

                        -- True once every Hour
                        if Minutes = 59 then
                            Minutes <= 0;

                            -- True once every day
                            if Hours = 23 then
                                Hours <= 0;
                            else
                                Hours <= Hours + 1;
                            end if;

                        else
                            Minutes <= Minutes + 1;

                        end if;

                    end if;

                    Seconds <= Seconds + 1;

                else

                    Ticks <= Ticks + 1;
                    
                end if;


            end if;
        end if;
    end process;

end architecture;