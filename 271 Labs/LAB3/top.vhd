library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        signal i_CLK  : IN  std_logic;
        signal i_SW   : IN  std_logic_vector(7 downto 0);
        signal i_KEY  : IN  std_logic_vector(3 downto 0);
        signal o_LEDR : OUT std_logic_vector(7 downto 0);
        signal o_LEDG : OUT std_logic_vector(3 downto 0);
        signal o_HEX0 : OUT std_logic_vector(6 downto 0);
        signal o_HEX1 : OUT std_logic_vector(6 downto 0)
    );
end entity;

architecture rtl of top is
    signal driver_i : std_logic_vector(7 downto 0) := (others => '0');
    signal lut_o    : std_logic;
    signal button_o : std_logic;
    signal logic_o  : std_logic := '0';
begin

    -- debug leds for switches
    o_LEDR(2 downto 0) <= i_SW(2 downto 0);

    -- zero out all unused pins on input to driver
    -- driver_i(7 downto 1) <= (others => '0');

    -- logic to switch led output between custom logic and mux
    driver_i(0) <= ((logic_o and button_o) or (lut_o and not button_o));

    -- reduced implementation with K-map (produces same output as MUX)
    logic_o <= i_SW(1) OR i_SW(2);

    -- debouncer entity
    DB : entity work.debounce(behavioral)
			generic map(
            clkFreq => 50e6
        )
        port map(
            i_clk => i_CLK,
            i_button => not i_KEY(0),
            o_button => button_o
        );
		  
		  
    o_LEDG(0) <= button_o;

    -- auto generated 8 input MUX
    LUT : entity work.MUX8(behavioral)
        port map(
            i_input => "00111111", -- even even odd odd odd odd odd odd (0 for even | 1 for odd)
            i_select => not i_SW(2 downto 0),
            o_out => lut_o
        );

    -- Dr. G's 7seg driver
    DRIVER : entity work.Eight_Seg_Display_Out(Behavior)
        port map(
            clk => i_CLK,
            data => driver_i,
            output1 => o_HEX0,
            output2 => o_HEX1
        );
   
    
end architecture; -- arch
