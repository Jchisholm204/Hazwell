library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port(
        signal i_CLK  : IN  std_logic;
        signal i_SW   : IN  std_logic_vector(7 downto 0);
        signal i_KEY  : IN  std_logic_vector(3 downto 0);
        signal o_LEDR : OUT std_logic_vector(7 downto 0);
        signal o_LEDG : OUT std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of top is
    signal Key1 : std_logic;
    signal Key2 : std_logic;
begin
    k1: entity work.debounce(behavioral)
    generic map(
      clkFreq => 50e3
    )
    port map(
        i_clk => i_CLK,
        o_button => Key1,
        i_button => i_KEY(0)
    );

    k2: entity work.debounce(behavioral)
    generic map(
      clkFreq => 50e3
    )
    port map(
        i_clk => i_CLK,
        o_button => Key2,
        i_button => i_KEY(1)
    );

    o_LEDG(0) <= Key1 OR  Key2;
    o_LEDG(1) <= Key1 AND Key2;
    o_LEDG(2) <= Key1 XOR Key2;

    process(i_CLK) is
        begin
            if(rising_edge(i_CLK)) then
                if(Key1 = '1') then
                    if(i_SW = "00000000") then
                        o_LEDR <= "11111111";
                    else
                        o_LEDR <= i_SW;
                    end if;
                else
                    o_LEDR <= i_SW;
                end if;
            end if;
    end process;
    
    
    
    end architecture; -- arch
