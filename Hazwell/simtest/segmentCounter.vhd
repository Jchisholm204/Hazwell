library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity segmentCounter is
    port(
        -- Inputs
        nRst       : in std_logic;
        Clk        : in std_logic; -- PIN_N2

        -- Outputs
        DispSeg1 : out std_logic_vector(6 downto 0);
        DispSeg2 : out std_logic_vector(6 downto 0);
        DispSeg3 : out std_logic_vector(6 downto 0)

    );
end entity;

architecture rtl of segmentCounter is

    -- Constants
    constant ClockFrequency : integer := 50e6; -- 100MHz
    --constant ClockFrequency : integer := 10; -- 10Hz
    --constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
    constant BitWidth_Seg   : integer := 8;
  
    -- Numbers for the display
    signal Seg1 : unsigned(BitWidth_Seg-1 downto 0) := (others => 'X');
    signal Seg2 : unsigned(BitWidth_Seg-1 downto 0) := (others => 'X');
    signal Seg3 : unsigned(BitWidth_Seg-1 downto 0) := (others => 'X');

    -- Counter
    signal Counter : integer := 0;

    pure function f_sevenSegment( num : unsigned(7 downto 0) := (others => 'X') )
        return std_logic_vector is
            variable DispSeg : std_logic_vector(6 downto 0);
    begin
        case num is
            when "00000000" => DispSeg := "1000000";
            when "00000001" => DispSeg := "1111001";
            when "00000010" => DispSeg := "0100100";
            when "00000011" => DispSeg := "0110000";
            when "00000100" => DispSeg := "0011001";
            when "00000101" => DispSeg := "0010110";
            when "00000110" => DispSeg := "0000010";
            when "00000111" => DispSeg := "1111000";
            when "00001000" => DispSeg := "0000000";
            when "00001001" => DispSeg := "0011000";
            when others =>
                DispSeg := (others => 'X');
        end case;
        return DispSeg;
    end function;
  
begin

    i_Timer : entity work.timer(rtl)
    generic map(ClockFrequency => ClockFrequency)
    port map(
        Clk => Clk,
        nRst => nRst,
        Seconds => Counter
    );

    process(Counter) is
    begin
        Seg1 <= to_unsigned(Counter, BitWidth_Seg)     mod 10;
        Seg2 <= to_unsigned(Counter, BitWidth_Seg)/10  mod 10;
        Seg3 <= to_unsigned(Counter, BitWidth_Seg)/100 mod 10;
    end process;

    process(Seg1) is
    begin
        DispSeg1 <= f_sevenSegment( num => Seg1);
    end process;

    process(Seg2) is
    begin
        DispSeg2 <= f_sevenSegment( num => Seg2);
    end process;

    process(Seg3) is
    begin
        DispSeg3 <= f_sevenSegment( num => Seg3);
    end process;
    
end architecture;





