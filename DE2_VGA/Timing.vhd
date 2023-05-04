library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--- https://xess.com/blog/vga-the-rest-of-the-story/index.html
--- https://web.mit.edu/6.111/www/labkit/vga.shtml#:~:text=VGA%20is%20a%20high%2Dresolution,vertical%20and%20horizontal%20synchronization%20signals.

entity Timing is
	port (
		i_Clk     : in   std_logic;
		vga_clk   : in   std_logic;
		vga_vsync : out  std_logic;
		vga_hsync : out  std_logic;
		vga_r     : out  std_logic_vector(7 downto 0);
		vga_g     : out  std_logic_vector(7 downto 0);
		vga_b	  : out  std_logic_vector(7 downto 0)
	);
end entity Timing;

architecture rtl of Timing is
	type   vga_state is (t_activeVideo, t_frontPorch, t_syncPulse, t_backPorch);
	signal h_state : t_state := t_frontPorch;
	signal v_state : t_state := t_frontPorch;

	signal vCount  : integer := 0;
	signal hCount  : integer := 0;
	signal porch   : integer := 0;

begin
	
	process (vga_clk) is
	begin
		if rising_edge(vga_clk) then
			if h_state = t_activeVideo then
				if hCount > 480 then
					hCount  <= 0;
					h_state <= t_frontPorch;
				end if;
				vga_r	  <= 255;
				vga_g	  <= 0;
				vga_b 	  <= 0;
				vga_hsync <= '1';
				hCount 	  <= hCount + 1;
			elsif h_state = t_frontPorch then
				if hCount > 16 then
					hCount   <= 0;
					h_state  <= t_syncPulse;
				end if;
				vga_r 	  <= 0;
				vga_g 	  <= 0;
				vga_b 	  <= 0;
				vga_hsync <= '1';
				hCount    <= hCount + 1;
			elsif h_state = t_syncPulse then
				if hCount > 96 then
					hCount   <= 0;
					h_state  <= t_backPorch;
				end if;
				vga_r		 <= 0;
				vga_g		 <= 0;
				vga_b		 <= 0;
				vga_hsync	 <= '0';
				hCount		 <= hCount + 1;
			elsif h_state = t_backPorch then
				if hCount > 


			
				


end architecture;