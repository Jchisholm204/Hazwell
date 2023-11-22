library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity flipFlop is
    port(
        Clk    : in std_logic;
        nRst   : in std_logic; -- Negative Reset
        Input  : in std_logic;
        Output : out std_logic
    );
end entity;

architecture rtl of flipFlop is
begin

    process(Clk) is
    begin
        if rising_edge(Clk) then
            if nRst = '0' then
                Output <= '0';
            else
                Output <= Input;
            end if;
        end if;
    end process;

end architecture;