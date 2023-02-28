library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
	port(
		dipSwitches : in std_logic_vector(7 downto 0);
		ledr0 : OUT STD_LOGIC;
		hex0 : out std_logic_vector(6 downto 0)

	);
end top;

architecture main of top is
	signal number : std_logic_vector(7 downto 0);
begin

	number <= dipSwitches;

	process(number) is
	begin
	
		if number = "00000000" then
			hex0 <= "1000000"; -- 0 is on
		elsif number = "00000001" then
			hex0 <= "1111001"; -- 6 5 4 3 2 1 0
		end if;
		
	end process;

				
end architecture;
