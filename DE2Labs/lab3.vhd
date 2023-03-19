library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lab3 is
end entity;

architecture sim of lab3 is

    signal Clk : std_logic := '0';
    signal R   : std_logic := '0';
    signal S   : std_logic := '0';
    signal Q   : std_logic := '0';
    
    Signal R_g, S_g, Qa, Qb : std_logic;

    begin
        process(Clk, R) is
            begin
            R_g <= R and Clk;
            S_g <= S and Clk;
            Qa  <= not (R_g or Qb);
            Qb  <= not (S_g or Qa);

            Q <= Qa;
        end process;

        process is
            begin
                Clk <= not Clk;
                wait for 10 ns;
        end process;

        process is
            begin
                R <= '0';
                S <= '0';
                wait for 10 ns;
                R <= '1';
                S <= '0';
                wait for 10 ns;
                R <= '0';
                S <= '1';
                wait for 10 ns;
                R <= '1';
                S <= '1';
                wait for 10 ns;
                R <= '0';
                S <= '0';
        end process;

    
end architecture sim;