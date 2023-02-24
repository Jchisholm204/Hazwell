library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	port(
		s0, s1, s2 : IN STD_LOGIC;
		ledr0 : OUT STD_LOGIC;
		hex0 : out std_logic_vector(6 downto 0)

	);
end top;

architecture main of top is
signal num : unsigned(7 downto 0);
begin

	main : process(num) begin
	if (s0 = '0') then
	hex0 <= "1000000"; -- 0 is on
	elsif s0 = '1' then
	hex0 <= "1111001"; -- 6 5 4 3 2 1 0
	end if;
	end process main;

				
end architecture;
