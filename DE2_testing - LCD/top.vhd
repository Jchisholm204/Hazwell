library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is
    port(
        -- Inputs
        i_SW   : in std_logic_vector(12 downto 0);

        -- 7 Segment Displays
        o_HEX0       : out std_logic_vector(6 downto 0);
        o_HEX1       : out std_logic_vector(6 downto 0);
        o_HEX2       : out std_logic_vector(6 downto 0);
        o_HEX3       : out std_logic_vector(6 downto 0);

        -- LCD
        LCD_DATA     : inout std_logic_vector(7 downto 0);
        LCD_RW       : out std_logic;
        LCD_EN       : out std_logic;
        LCD_RS       : out std_logic;
        LCD_ON       : out std_logic;
        LCD_BLON     : out std_logic;
		
        -- Clock Input (50 MHz)
		i_Clk        : in std_logic

    );
end entity;

architecture rtl of top is
	 
    signal dispn: integer := 0;

begin

    segments : work.sevensegments(behavioral)
        port map(
            i_dispNum => dispn,
            o_DispSeg1 => o_HEX0,
            o_DispSeg2 => o_HEX1,
            o_DispSeg3 => o_HEX2,
            o_DispSeg4 => o_HEX3
        );
		  
	process(i_Clk) is
    begin
        dispn <= to_integer(unsigned(i_SW));
    end process;
    
end architecture;





