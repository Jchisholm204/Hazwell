library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevensegments is
    port(
        i_dispNum   : in  integer;
        o_DispSeg1  : out std_logic_vector(6 downto 0);
        o_DispSeg2  : out std_logic_vector(6 downto 0)
    );
end entity;

architecture behavioral of sevensegments is

    signal Seg1 : unsigned(7 downto 0) := (others => 'X');
    signal Seg2 : unsigned(7 downto 0) := (others => 'X');

    pure function f_sevenSegment( num : unsigned(7 downto 0) := (others => 'X') )
        return std_logic_vector is
            variable DispSeg : std_logic_vector(6 downto 0);
    begin
        case num is
            when "00000000" => DispSeg := "1000000"; -- 0
            when "00000001" => DispSeg := "1111001"; -- 1
            when "00000010" => DispSeg := "0100100"; -- 2
            when "00000011" => DispSeg := "0110000"; -- 3
            when "00000100" => DispSeg := "0011001"; -- 4
            when "00000101" => DispSeg := "0010010"; -- 5
            when "00000110" => DispSeg := "0000010"; -- 6
            when "00000111" => DispSeg := "1111000"; -- 7
            when "00001000" => DispSeg := "0000000"; -- 8
            when "00001001" => DispSeg := "0010000"; -- 9
            when others =>
                DispSeg := (others => 'X');
        end case;
        return DispSeg;
    end function;

begin

    process(i_dispNum) is
    begin
        Seg1 <= to_unsigned((i_dispNum      mod 10), Seg1'length);
        Seg2 <= to_unsigned((i_dispNum/10   mod 10), Seg2'length);
    end process;

    process(Seg1) is
    begin
        o_DispSeg1 <= f_sevenSegment( num => Seg1 );
    end process;

    process(Seg2) is
    begin
        o_DispSeg2 <= f_sevenSegment( num => Seg2 );
    end process;

end architecture;
