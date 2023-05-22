library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_controller is
    port(
        LCD_DATA     : inout std_logic_vector(7 downto 0);
        LCD_RW       : out std_logic;
        LCD_EN       : out std_logic;
        LCD_RS       : out std_logic;
        LCD_ON       : out std_logic;
        LCD_BLON     : out std_logic;

        i_Clk        : in std_logic;
        i_dispNum    : in integer
    );
end entity;

architecture behavioral of lcd_controller is

    type LCD_State is (VCC_Initialize, EN_EN, Instruct, LCD_Initialized);
    signal InitState            : LCD_State := VCC_Initialize;
    signal InitCounter          : integer   := 0;

begin

    init : process(i_Clk) is
    begin
        if rising_edge(i_Clk) then
            case InitState is
                when VCC_Initialize =>
                    LCD_DATA <= (others => '0');
                    LCD_RW   <= '0';
                    LCD_EN   <= '1';
                    LCD_RS   <= '0';
                    LCD_ON   <= '1';
                    LCD_BLON <= '1';
                    if InitCounter = 750000 then
                        InitCounter <= 0;
                        InitState   <= EN_EN;
                    else
                        InitCounter  <= InitCounter + 1;
                    end if;
                when EN_EN =>
                    LCD_DATA <= (others => '0');
                    LCD_RW   <= '0';
                    LCD_EN   <= '0';
                    LCD_RS   <= '0';
                    LCD_ON   <= '1';
                    LCD_BLON <= '1';
                    if InitCounter = 750000 then
                        InitCounter <= 0;
                        InitState   <= Instruct;
                    else
                        InitCounter  <= InitCounter + 1;
                    end if;
                when Instruct =>
                    LCD_DATA <= (4 => '1', 5 => '1', others => '0');
                    LCD_RW   <= '0';
                    LCD_EN   <= '0';
                    LCD_RS   <= '0';
                    LCD_ON   <= '1';
                    LCD_BLON <= '1';
                    if InitCounter = 1000000 then
                        InitCounter <= 0;
                        InitState   <= LCD_Initialized;
                    else
                        InitCounter  <= InitCounter + 1;
                    end if;
                when LCD_Initialized =>
                    LCD_DATA <= (4 => '1', 5 => '1', others => '0');
                    LCD_RW   <= '0';
                    LCD_EN   <= '0';
                    LCD_RS   <= '0';
                    LCD_ON   <= '1';
                    LCD_BLON <= '1';
            end case;
        end if;
    end process; 

end architecture;