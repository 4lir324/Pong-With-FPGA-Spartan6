
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RGB_mux is
    Port ( clk 			: in  STD_LOGIC;
           reset 			: in  STD_LOGIC;
           start_button : in  STD_LOGIC;
           rgb_start 	: in  STD_LOGIC_vector(2 downto 0);
           rgb_play 		: in  STD_LOGIC_vector(2 downto 0);
           rgb_gameover : in  STD_LOGIC_vector(2 downto 0);
           video_on 		: in  STD_LOGIC;
			  ball_y			: in integer range 0 to 480;
           RGB 			: out  STD_LOGIC_vector(2 downto 0));
end RGB_mux;

architecture Behavioral of RGB_mux is

signal state : std_logic_vector(1 downto 0):= "00";

constant bar_y 			: integer := 440;
constant ball_demention : integer := 20;

begin
	process(clk,reset)
	begin
	if(reset = '1') then
		state <= "00";
	
	elsif clk'event and clk = '1' then
				if(state = "00" and start_button = '1') then
					state <= "01";
					elsif (state = "01" and (ball_y > bar_y - ball_demention+30)) then --Game over
						state <= "10";
						elsif(state = "10" and start_button = '1') then
							state <= "01";
							end if;
	
	end if;

	end process;
	
--------------------------------------------------------------------------------
		RGB <= 			rgb_start 	 when (state = "00" and video_on = '1')
					else 	rgb_play  	 when (state = "01" and video_on = '1')
					else  rgb_gameover when (state = "10" and video_on = '1')
					else  "000";
end Behavioral;

