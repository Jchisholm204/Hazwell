entity lut8 is
    port (
        i_clk    : in  std_logic;
        i_select : out std_logic_vector(2 downto 0);
        o_out    : out std_logic
    );
end lut8;

architecture behavioral of lut8 is

begin
    LUT : process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            case i_select is
                when "000" => o_out <= '0'; --- 2
                when "001" => o_out <= '0'; --- 0
                when "010" => o_out <= '1'; --- 3
                when "011" => o_out <= '1'; --- 3
                when "100" => o_out <= '1'; --- 5
                when "101" => o_out <= '1'; --- odd
                when "110" => o_out <= '1'; --- odd
                when "111" => o_out <= '1'; --- odd           
                when others => o_out <= 'X'; -- undefined            
            end case;
        end if;
    end process;

end architecture;