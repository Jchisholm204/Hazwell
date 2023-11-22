library ieee;
use ieee.std_logic_1164.all;

entity adder is
    port(
        i1, i2 : in std_logic_vector(2 downto 0);
        o : out std_logic_vector(2 downto 0);
        overflow : out std_logic
    );
end entity;

architecture rtl of adder is

    signal carry : std_logic_vector(2 downto 0) := (others => '0');

begin
    o(0) <= i1(0) xor i2(0);
    carry(0) <= i1(0) and i2(0);

    o(1) <= (i1(1) xor i2(1)) xor carry(0);
    carry(1) <= (i1(1) and i2(1)) or (i1(1) and carry(0)) or (i2(0) and carry(0));

    overflow <= carry(1);


end architecture;