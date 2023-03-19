library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Altera VHDL Lab 5 - Part 3: Reaction Timer --

entity lab5 is
    port(
        -- Hex Displays
        HEX0 : out std_logic_vector(6 downto 0);    -- 7 Seg Disp
        HEX1 : out std_logic_vector(6 downto 0);    -- 7 Seg Disp
        HEX2 : out std_logic_vector(6 downto 0);    -- 7 Seg Disp

        KEY0 : in  std_logic;                       -- Reset Key
        KEY3 : in  std_logic;                       -- Start/End Key

        SW   : in  std_logic_vector(7 downto 0);    -- Time Set Switches

        Clk  : in  std_logic                        -- DE2 Clock
        
    );
end entity lab5;


architecture rtl of lab5 is
    
    --constant ClkFreq : integer := 50e6;
    constant ClkFreq : integer   := 10;
    signal   Ticks   : integer   := 0;
    signal   Millis  : integer   := 0;
    signal   Seconds : integer   := 0;
    signal   running : std_logic := '0';
    signal   delay   : integer   := 0;
    signal   nRst    : std_logic := '0';


    pure function f_NumTOSeven_Segment( num : integer := 0)
        return std_logic_vector is
            variable DispSeg : std_logic_vector(6 downto 0);
    begin
        case num is
            when 0 => DispSeg := "1000000"; -- 0
            when 1 => DispSeg := "1111001"; -- 1
            when 2 => DispSeg := "0100100"; -- 2
            when 3 => DispSeg := "0110000"; -- 3
            when 4 => DispSeg := "0011001"; -- 4
            when 5 => DispSeg := "0010010"; -- 5
            when 6 => DispSeg := "0000010"; -- 6
            when 7 => DispSeg := "1111000"; -- 7
            when 8 => DispSeg := "0000000"; -- 8
            when 9 => DispSeg := "0010000"; -- 9
            when others =>
                DispSeg := (others => 'X');
        end case;
        return DispSeg;
    end function;
    

begin

    process( SW , running )
    begin
        delay <= to_integer(unsigned(SW));
    end process;

    process(Seconds, Millis, KEY3)
    begin
        if rising_edge(KEY3) then
            nRst <= '1';
        end if;
        
        if running = '0' then
            if Seconds < delay then
                HEX0 <= f_NumTOSeven_Segment(num => (delay - Seconds));
                HEX1 <= f_NumTOSeven_Segment(num => 0);
                HEX2 <= f_NumTOSeven_Segment(num => 0);

            elsif Seconds = delay then
                nRst    <= '1';
                running <= '1';

            end if;
        end if;

    end process;         
            
        
            


    -- Clock
    process( Clk, nRst )
    begin
        if nRst = '1' then
            Ticks   <= 0;
            Millis  <= 0;
            Seconds <= 0;
            nRst    <= '1';
        end if;
        if rising_edge( Clk ) then
            if Ticks * 1000 = ClkFreq - 1 then
                Ticks <= 0;
                if Millis = 999 then
                    Millis <= 0;

                else
                    Millis <= Millis + 1;

                end if;
            
            else
                Ticks <= Ticks + 1;
            end if;

        end if;

    end process; -- Clock

    process(Millis, running)
    begin
        if running = '1' then
            HEX0 <= f_NumTOSeven_Segment(num => (Millis     mod 10));
            HEX1 <= f_NumTOSeven_Segment(num => (Millis/10  mod 10));
            HEX2 <= f_NumTOSeven_Segment(num => (Millis/100 mod 10));
        end if;
    end process;
    

    process(KEY3)
    begin
        if rising_edge(KEY3) then
            running <= '0';
        end if;
    end process;
    
end architecture rtl;