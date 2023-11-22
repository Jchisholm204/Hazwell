library ieee;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity lab1 is
end entity;

architecture sim of lab1 is
    signal Sel      : std_logic_vector(2 downto 0)  := (others => '0');
    signal sig_U    : std_logic_vector(2 downto 0)  := "001";
    signal sig_V    : std_logic_vector(2 downto 0)  := "010";
    signal sig_W    : std_logic_vector(2 downto 0)  := "011";
    signal sig_X    : std_logic_vector(2 downto 0)  := "100";
    signal sig_Y    : std_logic_vector(2 downto 0)  := "101";
    signal M        : std_logic_vector(2 downto 0)  := (others => '0');


begin

    process(Sel) is
    begin
        case Sel is
            when "000"  => M <= sig_U;
            when "001"  => M <= sig_V;
            when "010"  => M <= sig_W;
            when "011"  => M <= sig_X;
            when others => M <= sig_Y;
        end case;
    end process;

    -- Testbench Code
    process is
    begin
        wait for 10 ns;
        Sel <= "001";
        wait for 10 ns;
        Sel <= "010";
        wait for 10 ns;
        Sel <= "011";
        wait for 10 ns;
        Sel <= "100";
        wait for 10 ns;
        Sel <= "101";
        wait;
    end process;

end architecture;