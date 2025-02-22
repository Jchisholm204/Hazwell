library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.charString.all;

entity lcd_driver_core is
    port (
        i_Clk_50MHz             : in     std_logic;
        i_nRst                  : in     std_logic;
        
        r_LCD_DATA              : inout  std_logic_vector(7 downto 0);
        o_LCD_ON                : out    std_logic;
        o_LCD_BLON              : out    std_logic;
        o_LCD_RW                : out    std_logic;
        o_LCD_RS                : out    std_logic;
        o_LCD_EN                : out    std_logic;

        lcd_display_string      : in     characterString

    );
end entity;

architecture rtl of lcd_driver_core is

    signal clk_count_400hz              : integer     := 0;
    signal clk_400hz_enable, lcd_rw_int : std_logic   := '0';

    type lcd_state_type is (func_set, display_on, mode_set, print_string,
                            line2, return_home, drop_lcd_e, reset1, reset2,
                            reset3, display_off, display_clear );
    
    signal state, next_command       : lcd_state_type;

    signal data_bus_value, next_char : std_logic_vector(7 downto 0);
    signal char_count                : integer := 0;




begin

    -- BIDIRECTIONAL TRI STATE LCD DATA BUS
    r_LCD_DATA <= data_bus_value when lcd_rw = '0' else (others => 'Z');

    -- LCD_RW PORT is assigned to it matching SIGNAL 
    o_LCD_RW <= lcd_rw_int;


    clock400Hz : process (i_Clk_50MHz, i_nRst) is
    begin
        if rising_edge(i_Clk_50MHz) then
            if i_nRst = '0' then
                clk_count   <= 0;
                o_Clk_400Hz <= '0';
            else
                if clk_count <= x"00F424" then
                    clk_count <= clk_count + 1;
                    clk_400hz_enable <= '0';
                else
                    clk_count_400hz <= 0;
                    clk_400hz_enable <= '1';
                end if;
            end if;
        end if;
    end process;

    process (i_Clk_50MHz, i_nRst) is
    begin
        if i_nRst = '0' then
            state <= reset1;
            data_bus_value <= x"38"; -- RESET
            next_command <= reset2;
            o_LCD_EN <= '1';
            o_LCD_RS <= '0';
            lcd_rw_int <= '0';

        elsif rising_edge(i_Clk_50MHz) then
            if clk_400hz_enable = '1' then
                case state is
                    when reset1 =>
                        o_LCD_EN <= '1';
                        o_LCD_RS <= '0';
                        lcd_rw_int <= '0';
                        data_bus_value <= x"38";
                        state <= drop_lcd_e;
                        next_command <= reset2;
                        char_count <= 0;

                    when reset2 =>
                        o_LCD_EN <= '1';
                        o_LCD_RS <= '0';
                        lcd_rw_int <= '0';
                        data_bus_value <= x"38";
                        state <= drop_lcd_e;
                        next_command <= reset3;

                    when reset3 =>
                        o_LCD_EN <= '1';
                        o_LCD_RS <= '0';
                        lcd_rw_int <= '0';
                        data_bus_value <= x"38";
                        state <= drop_lcd_e;
                        next_command <= func_set;
        
                    -- Function Set
                    --==============--
                    when func_set =>                
                        lcd_e <= '1';
                        lcd_rs <= '0';
                        lcd_rw_int <= '0';
                        data_bus_value <= x"38";  -- Set Function to 8-bit transfer, 2 line display and a 5x8 Font size
                        state <= drop_lcd_e;
                        next_command <= display_off;
                        
                        
                        
                    -- Turn off Display
                    --==============-- 
                    when display_off =>
                        lcd_e <= '1';
                        lcd_rs <= '0';
                        lcd_rw_int <= '0';
                        data_bus_value <= x"08"; -- Turns OFF the Display, Cursor OFF and Blinking Cursor Position OFF.......
                                                    -- (0F = Display ON and Cursor ON, Blinking cursor position ON)
                        state <= drop_lcd_e;
                        next_command <= display_clear;
                        
                        
                    -- Clear Display 
                    --==============--
                    when display_clear =>
                        lcd_e <= '1';
                        lcd_rs <= '0';
                        lcd_rw_int <= '0';
                        data_bus_value <= x"01"; -- Clears the Display    
                        state <= drop_lcd_e;
                        next_command <= display_on;
                        
                        
                        
                    -- Turn on Display and Turn off cursor
                    --===================================--
                    when display_on =>
                        lcd_e <= '1';
                        lcd_rs <= '0';
                        lcd_rw_int <= '0';
                        data_bus_value <= x"0C"; -- Turns on the Display (0E = Display ON, Cursor ON and Blinking cursor OFF) 
                        state <= drop_lcd_e;
                        next_command <= mode_set;
                        
                        
                    -- Set write mode to auto increment address and move cursor to the right
                    --====================================================================--
                    when mode_set =>
                        lcd_e <= '1';
                        lcd_rs <= '0';
                        lcd_rw_int <= '0';
                        data_bus_value <= x"06"; -- Auto increment address and move cursor to the right
                        state <= drop_lcd_e;
                        next_command <= print_string;

                    