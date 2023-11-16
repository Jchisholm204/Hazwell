library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Lab4_traffic is
    port(
        button_in      : in  std_logic;
        reset          : in  std_logic;
        Light1_Green   : out std_logic;
        Light1_Yellow  : out std_logic;
        Light1_Red     : out std_logic;
        Light2_Green   : out std_logic;
        Light2_Yellow  : out std_logic;
        Light2_Red     : out std_logic;
        Light3_Green   : out std_logic;
        Light3_Yellow  : out std_logic;
        Light3_Red     : out std_logic;
        state_o        : out integer
    );
end entity;

architecture rtl of Lab4_traffic is
--Why do we not need a Red states?
    type lights_state is (Straight_Green, Straight_Yellow, T_Green, T_Yellow);
    signal State : lights_state;
    signal bbc : integer := 0; -- big button counter
begin
    process(button_in, reset) is
    begin
    if reset = '0' then
        -- set things to Straight_Green to reset
            State <= Straight_Green;
            Light1_Green   <= '1';
            Light1_Yellow  <= '0';
            Light1_Red     <= '0';
            Light2_Green   <= '0';
            Light2_Yellow  <= '0';
            Light2_Red     <= '1';
            Light3_Green   <= '1';
            Light3_Yellow  <= '0';
            Light3_Red     <= '0';
            bbc            <= 0;
            state_o <= 99;
        else
        if rising_edge(button_in) then
            case State is
                when Straight_Green =>
                    state_o <= 0;
                    Light1_Green  <= '1';
                    Light1_Yellow <= '0';
                    Light1_Red    <= '0';
                    Light2_Green  <= '0';
                    Light2_Yellow <= '0';
                    Light2_Red    <= '1';
                    Light3_Green  <= '1';
                    Light3_Yellow <= '0';
                    Light3_Red    <= '0';
                    if(bbc = 2) then
                        State <= Straight_Yellow;
                        bbc <= 0;
                    else bbc <= bbc + 1;
                    end if;
                when Straight_Yellow =>
                    state_o <= 1;
                    Light1_Green <= '0';
                    Light1_Yellow <= '1';
                    Light1_Red <= '0';
                    Light2_Green <= '0';
                    Light2_Yellow <= '0';
                    Light2_Red <= '1';
                    Light3_Green <= '0';
                    Light3_Yellow <= '1';
                    Light3_Red <= '0';
                    State <= T_Green;
                when T_Green =>
                    state_o <= 2;
                    Light1_Green <= '0';
                    Light1_Yellow <= '0';
                    Light1_Red <= '1';
                    Light2_Green <= '1';
                    Light2_Yellow <= '0';
                    Light2_Red <= '0';
                    Light3_Green <= '0';
                    Light3_Yellow <= '0';
                    Light3_Red <= '1';
                    if(bbc = 2) then
                        State <= T_Yellow;
                        bbc <= 0;
                    else bbc <= bbc + 1;
                    end if;
                when T_Yellow =>
                    state_o <= 3;
                    Light1_Green <= '0';
                    Light1_Yellow <= '0';
                    Light1_Red <= '1';
                    Light2_Green <= '0';
                    Light2_Yellow <= '1';
                    Light2_Red <= '0';
                    Light3_Green <= '0';
                    Light3_Yellow <= '0';
                    Light3_Red <= '1';
                    State <= Straight_Green;
                when others =>
                    state_o <= 0;
                    Light1_Green <= '0';
                    Light1_Yellow <= '0';
                    Light1_Red <= '1';
                    Light2_Green <= '0';
                    Light2_Yellow <= '0';
                    Light2_Red <= '1';
                    Light3_Green <= '0';
                    Light3_Yellow <= '0';
                    Light3_Red <= '1';
            end case;
        end if;
        end if;
    end process;
end architecture;