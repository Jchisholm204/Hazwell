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

        HEX0         : out std_logic_vector(6 downto 0);
        HEX1         : out std_logic_vector(6 downto 0);
        HEX2         : out std_logic_vector(6 downto 0);
        HEX3         : out std_logic_vector(6 downto 0);
        HEX4         : out std_logic_vector(6 downto 0);
        HEX5         : out std_logic_vector(6 downto 0);
        HEX6         : out std_logic_vector(6 downto 0);
        HEX7         : out std_logic_vector(6 downto 0);
        
		
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
    
    signal dotlineCnt   : integer      := 0;

    signal nBallBounds  : std_logic    := '0';

    signal leftCursory  : integer      := 240;
    signal rightCursory : integer      := 240;
    constant cursorLen  : integer      := 80;

    signal cursorCount : integer      := 0;

    signal scoreRight  : integer      := 0;
    signal scoreLeft   : integer      := 0;

begin

    rightScore : work.sevensegments(behavioral)
        port map(
            i_dispNum => scoreRight,
            o_DispSeg1 => HEX4,
            o_DispSeg2 => HEX5
        );

    leftScore : work.sevensegments(behavioral)
        port map(
            i_dispNum => scoreLeft,
            o_DispSeg1 => HEX6,
            o_DispSeg2 => HEX7
        );

    HEX0 <= (others => '1');
    HEX1 <= (others => '1');
    HEX2 <= (others => '1');
    HEX3 <= (others => '1');

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
                if y = 0 or y = 479 then
                    VGA_R <= (others => '1');
                    VGA_G <= (others => '1');
                    VGA_B <= (others => '1');
                -- draw ball
                elsif x < 5 and x > 2 and y < (leftCursory + cursorLen/2) and y > (leftCursory - cursorLen/2) then
                    VGA_R <= (others => '1');
                    VGA_G <= (others => '1');
                    VGA_B <= (others => '1');
                elsif x > 634 and x < 637 and y < (rightCursory + cursorLen/2) and y > (rightCursory - cursorLen/2) then
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
                -- draw dotted line
                elsif x < 328 and x > 322 then
                    if y < 10 or y > 470 then
                        VGA_R <= (others => '0');
                        VGA_G <= (others => '0');
                        VGA_B <= (others => '0');
                    elsif y mod 12 = 0 then
                        dotlineCnt <= 2;
                    elsif  dotlineCnt > 1 then
                        VGA_R <= (others => '0');
                        VGA_G <= (others => '0');
                        VGA_B <= (others => '0');
                        dotlineCnt <= dotlineCnt + 1;
                        if dotlineCnt = 21 then
                            dotlineCnt <= 0;
                        end if;
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
                if difficulty > 3*ballvx/4 then
                    difficulty <= 3*ballvx/4 -1;
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
            if ballx = 635 and balldirx = '1' then
                    if bally > (rightCursory - cursorLen/2) and bally < (rightCursory + cursorLen/2) then
                        balldirx <= '0';
                    else
                        ballx <= 320;
                        bally <= 240;
                        scoreLeft <= scoreLeft + 1;
                        if scoreLeft > 99 then
                            scoreLeft <= 0;
                        end if;
                    end if;
            elsif ballx = 5 and balldirx = '0' then
                if bally > (leftCursory - cursorLen/2) and bally < (leftCursory + cursorLen/2) then
                    balldirx <= '1';
                else
                    ballx <= 320;
                    bally <= 240;
                    scoreRight <= scoreRight + 1;
                    if scoreRight > 99 then
                        scoreRight <= 0;
                    end if;
                end if;
            end if;
            if bally = 475 then
                balldiry <= '0';
            elsif bally = 5 then
                balldiry <= '1';
            end if;

            -- auto cursor logic
                if balldirx = '1' then
                    

                    if cursorCount > 160 - difficulty/2 then
                        cursorCount <= 0;
                        if leftCursory < bally then
                            leftCursory <= leftCursory + 1;
                        elsif leftCursory > bally then
                            leftCursory <= leftCursory - 1;
                        end if;
                        if rightCursory < bally then
                        rightCursory <= rightCursory + 1;
                    elsif rightCursory > bally then
                        rightCursory <= rightCursory - 1;
                    end if;
                    else
                        cursorCount <= cursorCount + 1;
                    end if;
                else
                    if cursorCount > 160 - difficulty/2 then
                        cursorCount <= 0;
                        if rightCursory < bally then
                            rightCursory <= rightCursory + 1;
                        elsif rightCursory > bally then
                            rightCursory <= rightCursory - 1;
                        end if;
                        if leftCursory < bally then
                        leftCursory <= leftCursory + 1;
                    elsif leftCursory > bally then
                        leftCursory <= leftCursory - 1;
                    end if;
                    else
                        cursorCount <= cursorCount + 1;
                    end if;
                    
                end if;

        end if;
    end process;

    -- use sysclock for vga clk (800x600, 72Hz) => 50MHz pixel clock
    VGA_CLK      <= CLOCK_50;
    VGA_SYNC     <= '1';
    VGA_BLANK    <= VGA_HS and VGA_VS;
    

end architecture;