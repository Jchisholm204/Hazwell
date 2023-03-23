library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
    port(
        o_HEX0  : out std_logic_vector(6 downto 0);
        o_HEX1  : out std_logic_vector(6 downto 0);
        o_HEX2  : out std_logic_vector(6 downto 0);

        i_KEY0  : in  std_logic;
        i_KEY3  : in  std_logic;

        i_SW    : in  std_logic_vector(2 downto 0);

        i_Clk   : in  std_logic
    );

end entity;

architecture rtl of top is
    
    constant k_ClkFreq  : integer    := 10000;

    -- Clock Signals
    signal   j_Millis   : integer    := 0;
    signal   j_Seconds  : integer    := 0;
    signal   j_nRst     : std_logic  := '0';
    signal   e_Millis   : integer    := 0;
    signal   e_Seconds  : integer    := 0;
    signal   e_nRst     : std_logic  := '0';
    -- Program States
    signal   s_await    : std_logic  := '1'; -- Nothing is Running
    signal   s_wait     : std_logic  := '0'; -- Test Initiated (counting down)
    signal   s_running  : std_logic  := '0'; -- Running reaction time test


    -- Convert numbers into  7 Segment Display outputs
    pure function f_numToHEX( i_num : integer := 0)
        return std_logic_vector is
            variable o_Rton  : std_logic_vector(6 downto 0);
        begin
            case i_num is
                when 0 => o_Rton := "1000000"; -- 0
                when 1 => o_Rton := "1111001"; -- 1
                when 2 => o_Rton := "0100100"; -- 2
                when 3 => o_Rton := "0110000"; -- 3
                when 4 => o_Rton := "0011001"; -- 4
                when 5 => o_Rton := "0010010"; -- 5
                when 6 => o_Rton := "0000010"; -- 6
                when 7 => o_Rton := "1111000"; -- 7
                when 8 => o_Rton := "0000000"; -- 8
                when 9 => o_Rton := "0010000"; -- 9
                when others =>
                    o_Rton := (others => 'X');
            end case;
            return o_Rton;
    end function;


begin

    -- Create Clock Entity
    j_clock : entity work.clock(rtl)
    generic map(
        ClkFreq => k_ClkFreq
    )
    port map(
        nRst    => j_nRst,
        Clk     => i_Clk,
        Millis  => j_Millis,
        Seconds => j_Seconds
    );

    -- Create Clock Entity
    e_clock : entity work.clock(rtl)
    generic map(
        ClkFreq => k_ClkFreq
    )
    port map(
        nRst    => e_nRst,
        Clk     => i_Clk,
        Millis  => e_Millis,
        Seconds => e_Seconds
    );


    -- Process: Clock Processor
    process( i_Clk, s_await, s_wait, s_running, j_Seconds, i_KEY3 )
    begin
        if s_await = '1' and s_wait = '0' and s_running = '0' then
            if rising_edge(i_KEY3) then
                s_await   <= '0';
                s_wait    <= '1';
                j_nRst    <= '1';
            else
                j_nRst    <= '0';
                e_nRst    <= '0';
            end if;
        elsif s_await = '0' and s_wait = '1' and s_running = '0' then
            if j_Seconds = to_integer(unsigned(i_SW)) then
                s_running <= '1';
                s_wait    <= '0';
                j_nRst    <= '0';
                e_nRst    <= '1';
            else
                j_nRst <= '1';
                e_nRst <= '0';
            end if;
        elsif s_await = '0' and s_wait = '0' and s_running = '1' then
            j_nRst <= '0';
            e_nRst <= '1';
            if rising_edge(i_KEY3) then
                s_await   <= '1';
                s_running <= '0';
            elsif j_Millis > 999 then
                s_await   <= '1';
                s_running <= '0';               
            end if;
        end if;


    end process;
        
    -- Process: displays
    process(s_await, s_wait, s_running, j_Seconds, e_Millis) is
    begin
        if s_await = '0' and s_wait = '1' and s_running = '0' then
            o_HEX0 <= f_numToHEX(to_integer(unsigned(i_SW)) - j_Seconds);
            o_HEX1 <= (others => '1');
            o_HEX2 <= (others => '1');
        elsif s_await = '0' and s_wait = '0' and s_running = '1' then
            o_HEX0   <= f_numToHEX(e_Millis     mod 10);
            o_HEX1   <= f_numToHEX(e_Millis/10  mod 10);
            o_HEX2   <= f_numToHex(e_Millis/100 mod 10);
        end if;
    end process;

end architecture rtl;