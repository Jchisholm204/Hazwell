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
    type     t_state is
        (t_await, t_wait, t_run);
    signal   ProgState  : t_state    := t_await;
	-- Button Signals
    signal   s_KEY0     : std_logic  := '0';
    signal   s_KEY3     : std_logic  := '0';
    signal   s_KEY3_last: std_logic  := '0';

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

    -- Software Debounce Button
    i_debounce_key3 : entity work.debounce(rtl)
    generic map (
        debounceTicks => 10
    )
    port map (
        i_Clk    => i_Clk,
        i_button => i_KEY3,
        o_button => s_KEY3
    );


    -- Process: Clock Processor
    process( i_Clk )
    begin
        if rising_edge(i_Clk) then
            case ProgState is
                when t_await =>
                    if s_KEY3 = '1' and s_KEY3_last = '0' then
                        ProgState <= t_wait;
                        j_nRst    <= '1';
                        e_nRst    <= '0';
                    else
                        j_nRst    <= '0';
                        e_nRst    <= '0';
                    end if;

                when t_wait =>
                    if j_Seconds = to_integer(unsigned(i_SW)) then
                        ProgState <= t_run;
                        j_nRst    <= '0';
                        e_nRst    <= '1';
                    else
                        j_nRst    <= '1';
                        e_nRst    <= '0';
                    end if;
                    o_HEX0 <= f_numToHEX(to_integer(unsigned(i_SW)) - j_Seconds);
                    o_HEX1 <= (others => '1');
                    o_HEX2 <= (others => '1');
                when others =>
                    j_nRst <= '0';
                    e_nRst <= '1';
                    o_HEX0   <= f_numToHEX(e_Millis     mod 10);
                    o_HEX1   <= f_numToHEX(e_Millis/10  mod 10);
                    o_HEX2   <= f_numToHex(e_Millis/100 mod 10);
                    if s_KEY3 = '1' and s_KEY3_last = '0' then
                        ProgState <= t_await;
                    end if;
            end case;
            s_KEY3_last <= s_KEY3;
        end if;
    end process;

end architecture rtl;