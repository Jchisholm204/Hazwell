library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity debounce is
    generic (
        debounceTicks : integer
    );
    port (
        i_Clk    : in  std_logic;
        i_button : in  std_logic;
        o_button : out std_logic
    );
end debounce;

architecture rtl of debounce is
    signal ticks     : integer   :=  0;
    signal PrevState : std_logic := '0';
    signal CurrState : std_logic := '0';

begin
    process (i_Clk) is
    begin
        if rising_edge(i_Clk) then
            CurrState <= i_button;

            if i_button /= PrevState then
                ticks <= 0;
            else
                ticks <= ticks + 1;
            end if;
            
            if ticks > debounceTicks then
                o_button <= CurrState;
            end if;

            PrevState <= i_button;
        end if;
    end process;

end architecture;