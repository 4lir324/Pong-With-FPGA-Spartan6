
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity play_menu is
    Port ( clk          	: in  STD_LOGIC;                      --main input clock 50MHz
           reset        	: in  STD_LOGIC;                      --main low active reset
           button_left  	: in std_logic;
           button_right 	: in std_logic;
			  start_button		: in std_logic;
           x_counter       : in integer range 0 to 640;
           y_counter       : in integer range 0 to 480; 
			  ball_y 			: buffer integer range 0 to 480;
           RGB           	: out STD_LOGIC_VECTOR(2 downto 0));  --VGA RGB output
end play_menu;


Architecture Behavioral of play_menu is

--BackGround
    constant background_RGB : std_logic_vector(2 downto 0) := "000"; --black

----WALL signals
    constant wall_up_limit   : integer := 10;
    constant wall_down_limit : integer := 25;

    signal wall_on : std_logic;
    signal wall_RGB : std_logic_vector(2 downto 0);

----BALL signals
    constant ball_demention   : integer := 20;
    constant ball_speed       : integer := -3;
    signal  ball_y_speed              : integer;
    signal  ball_x_speed              : integer;

    signal ball_on : std_logic;
    signal ball_RGB : std_logic_vector(2 downto 0);
    signal ball_x : integer range 0 to 640;
   -- signal ball_y : integer range 0 to 480; --this signal declerate in PORT as buffer signal to send out

----BAR signals
    constant bar_x_demention   : integer := 120;
    constant bar_y_demention   : integer := 10;
    constant bar_speed          : integer := 6;
    
    signal  bar_on : std_logic;
    signal  bar_RGB : std_logic_vector(2 downto 0);
    signal  bar_x : integer range 0 to 640;
    constant bar_y : integer := 440;

    --video mux
    signal video_mux     : std_logic_vector(2 downto 0);


    ----Refresh signal
    signal refresh_tick : std_logic;
    signal refresh_reg,refresh_next : integer;
	 
	 
begin

--ball_y1 <= ball_y;
-----------------------------------------------------------------------------------------------------------------       
------------------------------------------- Draw WALL -----------------------------------------------------
    wall_on <= '1' when y_counter >=wall_up_limit and y_counter<= wall_down_limit else '0';
    wall_RGB <= "111";

------------------------------------------- Draw BALL -----------------------------------------------------
    ball_on <= '1' when (x_counter >=ball_x and x_counter<= ball_x + ball_demention) and (y_counter >=ball_y and y_counter<= ball_y + ball_demention)  else '0';
    ball_RGB <= "010";

------------------------------------------- Draw BAR -----------------------------------------------------
    bar_on <= '1' when (x_counter >=bar_x and x_counter<= bar_x + bar_x_demention) and (y_counter >=bar_y and y_counter<= bar_y + bar_y_demention)  else '0';
    bar_RGB <= "100";
	 
	 
	 
------------------------refresh timing
    process(clk,reset,start_button)
        variable refresh_counter : integer range 0 to 830000;
    begin
        if(reset = '1' OR start_button = '1')then
            refresh_counter := 0;
            bar_x  <= 180; --reset value
            ball_y <= 140; --reset value
            ball_x <= 320;  --reset value

				ball_x_speed <= 3;
				ball_y_speed <= 3;
				
        elsif clk'event and clk = '1' then
            refresh_counter := refresh_counter +1;
            if(refresh_counter = 830000) then
                refresh_counter := 0;

                -----------------------bar Animation
                if(button_left = '1' and bar_x> bar_speed+3) then
                    bar_x <= bar_x - bar_speed;
                elsif (button_right = '1' and bar_x < 639 - bar_x_demention - bar_speed) then
                    bar_x <= bar_x + bar_speed;
                    end if;

                -----------------------ball Animation y
                if( ball_y <= wall_down_limit ) then --OR (ball_y >= bar_y)
                    ball_y_speed <= -ball_speed;
                        elsif( (ball_y >= bar_y - ball_demention) and (ball_y <= bar_y - ball_demention+2) and ( ball_x >= bar_x - ball_demention) and ( ball_x <=bar_x + bar_x_demention )) then
                            ball_y_speed <= ball_speed;
                            end if;

                    ball_y <= ball_y + ball_y_speed;


                -----------------------ball Animation x
                if( ball_x <= 8 ) then 
                    ball_x_speed <= -ball_speed;
                    elsif( ball_x >= 635 - ball_demention) then
                        ball_x_speed <= ball_speed;
                        end if;
                    
                    ball_y <= ball_y + ball_y_speed;
                    ball_x <= ball_x + ball_x_speed;
                
            end if;

            
            
        end if;
    end process;

---------------------------------------------------------------------------------------
    video_mux <=  wall_on & bar_on & ball_on;

    with video_mux select
    RGB		   <=   background_RGB when "000",  --back ground
                    wall_RGB       when "100",
                    wall_RGB       when "101",
                    bar_RGB        when "010",
                    bar_RGB        when "011",
                    ball_RGB       when "001",
                    "000"          when Others;


end Behavioral;

