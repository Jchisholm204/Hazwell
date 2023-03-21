library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity topTB is
end entity;


architecture sim of topTB is
    signal o_HEX0  :  std_logic_vector(6 downto 0);
    signal o_HEX1  :  std_logic_vector(6 downto 0);
    signal o_HEX2  :  std_logic_vector(6 downto 0);

    signal i_KEY0  :  std_logic := '0';
    signal i_KEY3  :  std_logic := '0';

    signal i_SW    :  std_logic_vector(2 downto 0) := "001";

    signal i_Clk   :  std_logic := '0';

    constant ClkFreq        : integer := 50e1;
    constant ClockPeriod    : time    := 1000 ms / ClkFreq;
    
    constant k_ClkFreq  : integer    := 50e1;
    signal   e_Millis   : integer    := 0;
    signal   e_Seconds  : integer    := 0;
    signal   e_nRst     : std_logic  := '0';
    signal   j_Millis   : integer    := 0;
    signal   j_Seconds  : integer    := 0;
    signal   j_nRst     : std_logic  := '0';
    signal   s_running  : std_logic  := '0';
    signal   delay      : integer    := 0;

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

    -- Create Main Clock Entity
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

    -- Create Reaction Time Clock Entity
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


    -- Process: User Button Start Stop
    process(i_KEY3) is
    begin
        if s_running = '0' then
            if rising_edge(i_KEY3) then
                e_nRst    <= '1';
                j_nRst    <= '1';
                s_running <= '1';
            end if;
        else
            if rising_edge(i_KEY3) then
                s_running <= '0';
            end if;
        end if;
    end process;

    -- Process: Set Delay Using Switches
    process(i_SW) is
    begin
        delay <= to_integer(unsigned(i_SW));
    end process;

    -- Process: Runtime
    process(s_running, e_Seconds, j_Millis, delay) is
    begin
        if s_running = '1' then
            e_nRst       <= '1';
            if e_Seconds < delay then
                j_nRst   <= '0';
                o_HEX0   <= f_numToHEX((delay - e_Seconds));
                o_HEX1   <= f_numToHEX(0);
                o_HEX2   <= f_numToHex(0);
            else
                j_nRst   <= '1';
                o_HEX0   <= f_numToHEX(j_Millis     mod 10);
                o_HEX1   <= f_numToHEX(j_Millis/10  mod 10);
                o_HEX2   <= f_numToHex(j_Millis/100 mod 10);
            end if;
        end if;
    end process;
    


    --- TESTING
    i_Clk <= not i_Clk after ClockPeriod/2;

    process is
    begin
        i_KEY3 <= '1';
        wait until rising_edge(i_Clk);
        wait until rising_edge(i_Clk);
        i_KEY3 <= '0';
        wait for 1200 ms;
        i_KEY3 <= '1';
        wait until rising_edge(i_Clk);
        wait until rising_edge(i_Clk);
        i_KEY3 <= '0';
        wait;
    end process;
    
    
end architecture sim;