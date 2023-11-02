library ieee;
use ieee.std_logic_1164.all;

entity MUX8 is
    port (
        i_input  : in  std_logic_vector(7 downto 0);
        i_select : in std_logic_vector(2 downto 0);
        o_out    : out std_logic
    );
end MUX8;

architecture behavioral of MUX8 is

begin
    LUT : process(i_select)
    begin
        case i_select is
            when "000" => o_out <= i_input(0);
            when "001" => o_out <= i_input(1);
            when "010" => o_out <= i_input(2);
            when "011" => o_out <= i_input(3);
            when "100" => o_out <= i_input(4);
            when "101" => o_out <= i_input(5);
            when "110" => o_out <= i_input(6);
            when "111" => o_out <= i_input(7);          
            when others => o_out <= 'Z'; -- undefined            
        end case;
    end process;

end architecture;