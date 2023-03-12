library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        LCD_DATA : out std_logic_vector(7 downto 0); -- LCD controller data pins
        LCD_RW   : out std_logic;                    -- LCD read(1) / write(0) select
        LCD_EN   : out std_logic;                    -- Enable Pin
        LCD_RS   : out std_logic;                    -- LCD command(0) / data(1) selector
        LCD_ON   : out std_logic;                    -- LCD power on/off
        LCD_BLON : out std_logic;                    -- LCD backlight onn/off

        Clk      : in  std_logic                     -- Cyclone II 50MHz clock input

    );
end entity;

architecture rtl of top is
    constant ClkFrq : integer := 50e6; -- 50MHz
    
    signal DispInit : std_logic := 0;

    begin

    process(Clk, DispInit) is
    begin
        if(DispInit = '0') then
            LCD_ON <= '1';
            LCD_EN <= '1';

            LCD_DATA <= "00001100";

        end if;

    end process;

end architecture;