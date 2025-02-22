library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity DE2_testing is
    port(
        -- Inputs
        switches   : in std_logic_vector(7 downto 0);

        -- Outputs
        DispSeg1 : out std_logic_vector(6 downto 0);
        DispSeg2 : out std_logic_vector(6 downto 0);
        DispSeg3 : out std_logic_vector(6 downto 0);
		  
		  i_Clk    : in std_logic

    );
end entity;

architecture rtl of DE2_testing is
  
    -- Numbers for the display
    signal Seg1 : unsigned(7 downto 0) := (others => 'X');
    signal Seg2 : unsigned(7 downto 0) := (others => 'X');
    signal Seg3 : unsigned(7 downto 0) := (others => 'X');
	 
	 signal count: integer := 0;
	 signal dispn: integer := 0;

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

	process(i_Clk) is
	begin
		if rising_edge(i_Clk) then
			count <= count + 1;
			if count = 10e6 then
				dispn <= dispn + 1;
				count <= 0;
				if dispn = 255 then
					dispn <= 0;
				end if;
			end if;
		end if;
	end process;

    process(dispn, Seg1, Seg2, Seg3) is
    begin
        Seg1 <= to_unsigned(dispn, Seg1'length)     mod 10;
        Seg2 <= to_unsigned(dispn, Seg2'length)/10  mod 10;
        Seg3 <= to_unsigned(dispn, Seg3'length)/100 mod 10;
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





