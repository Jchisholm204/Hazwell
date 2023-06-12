LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity PS2 is
    port(
        PS2_Clk : in  std_logic;
        PS2_Dat : in  std_logic;
        n_Rst   : in  std_logic;
        ascii   : out std_logic_vector(7 downto 0);
        raw     : out std_logic_vector(10 downto 0);
        ps2     : out std_logic_vector(7 downto 0);
        busy    : out std_logic
    );
end entity;

architecture behavioral of PS2 is
    signal ClkCount     : integer := 0;
    signal i_busy       : std_logic;
    signal PS2_REG      : std_logic_vector(10 downto 0);
begin
    process(PS2_CLK) is
    begin
        if falling_edge(PS2_CLK) then
            PS2_REG  <= PS2_DAT & PS2_REG (10 downto 1);
            ClkCount <= ClkCount + 1;
            busy <= '1';
        end if;
        if ClkCount = 10 then
            raw  <= PS2_REG;
            ps2  <= PS2_REG(8 downto 1);
            busy <= '0';
            
    end process;