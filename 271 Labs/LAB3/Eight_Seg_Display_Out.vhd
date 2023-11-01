LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Eight_Seg_Display_Out IS
    PORT (
        clk: IN STD_LOGIC;
        data: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        output1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        output2: OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END Eight_Seg_Display_Out;

ARCHITECTURE Behavior of Eight_Seg_Display_Out IS
BEGIN
    PROCESS (clk)
    BEGIN
        if (clk'EVENT AND clk = '0') THEN
            CASE data(3 DOWNTO 0) IS
                WHEN "0000" =>
                output1 <= "1000000";
                WHEN "0001" =>
                output1 <= "1111001";
                WHEN "0010" =>
                output1 <= "0100100";
                WHEN "0011" =>
                output1 <= "0110000";
                WHEN "0100" =>
                output1 <= "0011001";
                WHEN "0101" =>
                output1 <= "0010010";
                WHEN "0110" =>
                output1 <= "0000010";
                WHEN "0111" =>
                output1 <= "1111000";
                WHEN "1000" =>
                output1 <= "0000000";
                WHEN "1001" =>
                output1 <= "0010000";
                WHEN "1010" =>
                output1 <= "0001000";
                WHEN "1011" =>
                output1 <= "0000011";
                WHEN "1100" =>
                output1 <= "1000110";
                WHEN "1101" =>
                output1 <= "0100001";
                WHEN "1110" =>
                output1 <= "0000110";
                WHEN "1111" =>
                output1 <= "0001110";
            END CASE;

            CASE data(7 DOWNTO 4) IS
                WHEN "0000" =>
                output2 <= "1000000";
                WHEN "0001" =>
                output2 <= "1111001";
                WHEN "0010" =>
                output2 <= "0100100";
                WHEN "0011" =>
                output2 <= "0110000";
                WHEN "0100" =>
                output2 <= "0011001";
                WHEN "0101" =>
                output2 <= "0010010";
                WHEN "0110" =>
                output2 <= "0000010";
                WHEN "0111" =>
                output2 <= "1111000";
                WHEN "1000" =>
                output2 <= "0000000";
                WHEN "1001" =>
                output2 <= "0010000";
                WHEN "1010" =>
                output2 <= "0001000";
                WHEN "1011" =>
                output2 <= "0000011";
                WHEN "1100" =>
                output2 <= "1000110";
                WHEN "1101" =>
                output2 <= "0100001";
                WHEN "1110" =>
                output2 <= "0000110";
                WHEN "1111" =>
                output2 <= "0001110";
            END CASE;
        END IF;
    END PROCESS;
END Behavior;