library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        LCD_DATA : inout std_logic_vector(7 downto 0); -- LCD controller data pins
        LCD_RW   : out   std_logic;                    -- LCD read(1) / write(0) select
        LCD_EN   : out   std_logic;                    -- Enable Pin
        LCD_RS   : out   std_logic;                    -- LCD command(0) / data(1) selector
        LCD_ON   : out   std_logic;                    -- LCD power on/off
        LCD_BLON : out   std_logic;                    -- LCD backlight onn/off

        i_Clk      : in    std_logic;                    -- Cyclone II 50MHz clock input
        n_Rst    : in    std_logic
    );
end entity;

architecture rtl of top is
    constant ClkFreq : integer := 50e6; -- 50MHz
    signal   ST      : integer := 0;

    begin

    process(i_Clk) is
    begin
        if n_Rst = '0' then
            -- Clear Display
            LCD_DATA <= "00000001";
            LCD_RS   <= '0';
            LCD_RW   <= '0';
            LCD_EN   <= '0';
            LCD_BLON <= '0';
            LCD_ON   <= '0';
            ST       <= 0;
        else
            LCD_BLON <= '1';
        end if;

    end process;

end architecture;