library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftRegTB is
end shiftRegTB;

architecture sim of shiftRegTB is

    signal PS2_CLK     : std_logic := '0';
    signal PS2_DAT     : std_logic := '0';
    signal Reg         : unsigned(10 downto 0);
    
    signal clkCnt      : integer := 0;

begin

    PS2_DAT <= not PS2_DAT after 20 ns;

    PS2_CLK <= not PS2_CLK after 10 ns;

    process (PS2_CLK) is
    begin
        if falling_edge(PS2_CLK) then
            Reg <= shift_left(Reg, 1);
            Reg(Reg'low) <= PS2_DAT;
        end if;
    end process;

end sim ; -- shiftRegTB