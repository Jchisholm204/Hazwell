library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is
    port(
        -- VGA Output
        VGA_R        : out std_logic_vector(9 downto 0);
        VGA_G        : out std_logic_vector(9 downto 0);
        VGA_B        : out std_logic_vector(9 downto 0);
        VGA_CLK      : out std_logic;
        VGA_BLANK    : out std_logic;
        VGA_HS       : inout std_logic;
        VGA_VS       : inout std_logic;
        VGA_SYNC     : out std_logic;
        
		
        -- Clock Input (50 MHz)
		CLOCK_50     : in  std_logic;

        LEDG0        : out std_logic;
        LEDG1        : out std_logic;
        KEY0         : in  std_logic;
        KEY1, KEY2   : in  std_logic

    );
end entity;

architecture rtl of top is

    signal x            : integer      := 0;
    signal y            : integer      := 0;
    signal rangeValid   : std_logic    := '0';

    signal CLOCK_25     : std_logic    := '0';

    signal timeCount    : integer      := 0;
    signal timeClock    : std_logic    := '0';

    signal ballx        : integer      := 0;
    signal bally        : integer      := 240;
    signal ballvx       : integer      := 180;
    signal velCountx    : integer      := 0;
    signal ballvy       : integer      := 200;
    signal velCounty    : integer      := 0;
    signal balldirx     : std_logic    := '1';
    signal balldiry     : std_logic    := '1';
    signal difficulty   : integer      := 0;
    signal dcount       : integer      := 0;

begin

    process(CLOCK_50) is
    begin
        if rising_edge(CLOCK_50) then
            CLOCK_25 <= not CLOCK_25;
        end if;
    end process;

    process(CLOCK_25) is
    begin
        if rising_edge(CLOCK_25) then
            if x < 799 then
                x <= x + 1;
            else
                x <= 0;
                if y < 524 then
                    y <= y + 1;
                else
                    y <= 0;
                end if;
            end if;
            
            if x < (640 + 16) or x >= (640 + 16 + 96) then
                VGA_HS            <= '1';
            else
                VGA_HS            <= '0';
            end if;
            if y < (480 + 10) or y >= (480 + 10 + 2) then
                VGA_VS            <= '1';
            else
                VGA_VS            <= '0';
            end if;

            if x < 640 and y < 480 then
                rangeValid        <= '1';
            else
                rangeValid        <= '0';
            end if;
            
            if rangeValid = '1' then
                -- draw border
                if x = 1 or x = 639 or y = 0 or y = 478 then
                    VGA_R <= (others => '1');
                    VGA_G <= (others => '1');
                    VGA_B <= (others => '1');
                elsif (x < (ballx + 3) and x > ballx - 3) and (y < (bally + 4) and y > bally -4) then
                    if x = (ballx - 2) and y = (bally - 3) then
                        VGA_R <= (others => '0');
                        VGA_G <= (others => '0');
                        VGA_B <= (others => '0');
                    elsif x = (ballx + 2) and y = (bally - 3) then
                        VGA_R <= (others => '0');
                        VGA_G <= (others => '0');
                        VGA_B <= (others => '0');
                    elsif x = (ballx - 2) and y = (bally + 3) then
                        VGA_R <= (others => '0');
                        VGA_G <= (others => '0');
                        VGA_B <= (others => '0');
                    elsif x = (ballx + 2) and y = (bally + 3) then
                        VGA_R <= (others => '0');
                        VGA_G <= (others => '0');
                        VGA_B <= (others => '0');
                    else
                        VGA_R <= (others => '1');
                        VGA_G <= (others => '1');
                        VGA_B <= (others => '1');
                    end if;
                else
                    VGA_R <= (others => '0');
                    VGA_G <= (others => '0');
                    VGA_B <= (others => '0');
                end if;
            else
                VGA_R <= (others => '0');
                VGA_G <= (others => '0');
                VGA_B <= (others => '0');
            end if;

        end if;
    end process;

    process (CLOCK_50) is
    begin
        if rising_edge(CLOCK_50) then
            timeCount <= timeCount + 1;
            if timeCount = 5e3 then
                timeClock <= not timeClock;
                timeCount <= 0;
            end if;
        end if;
    end process;

    process (timeClock) is
    begin
        if timeClock = '1' then
            dcount <= dcount + 1;
            if dcount = 2000 then
                difficulty <= difficulty + 1;
                if difficulty = ballvx then
                    difficulty <= (ballvx -1);
                end if;
                dcount <= 0;
            end if;
            if KEY0 = '0' then
                difficulty <= 0;
            elsif KEY1 = '0' then
                difficulty <= difficulty + 1;
            elsif KEY2 = '0' then
                difficulty <= difficulty - 1;
            end if;

            velCountx <= velCountx + 1;
            if velCountx > (ballvx - difficulty) then
                if balldirx = '1' then
                    ballx <= ballx + 1;
                else
                    ballx <= ballx - 1;
                end if;
                velCountx <= 0;
            end if;
            velCounty <= velCounty + 1;
            if velCounty > (ballvy - difficulty) then
                if balldiry = '1' then
                    bally <= bally + 1;
                else
                    bally <= bally - 1;
                end if;
                velCounty <= 0;
            end if;
            if ballx = 635 then
                balldirx <= '0';
            elsif ballx = 5 then
                balldirx <= '1';
            end if;
            if bally = 475 then
                balldiry <= '0';
            elsif bally = 5 then
                balldiry <= '1';
            end if;
        end if;
    end process;

    -- use sysclock for vga clk (800x600, 72Hz) => 50MHz pixel clock
    VGA_CLK      <= CLOCK_50;
    VGA_SYNC     <= '1';
    VGA_BLANK    <= VGA_HS and VGA_VS;
    LEDG0 <= not KEY1;
    LEDG1 <= not KEY2;
    

end architecture;