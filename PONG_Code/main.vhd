library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity main is
    Port ( 	clk 			 	: 	in  STD_LOGIC;
				reset 		 	: 	in  STD_LOGIC;
				h_sync       	: 	out STD_LOGIC;                      --VGA horizantal syncronous
				v_sync       	: 	out STD_LOGIC;                      --VGA vertical syncronous
            RGB          	:  out STD_LOGIC_VECTOR(2 downto 0);  --VGA RGB output  
				button_left  	: 	in std_logic;
				button_right   : 	in std_logic;
				start_button   : 	in std_logic);
				
end main;

Architecture Behavioral of main is

-------------------------------------------------sync_module
component sync_module is
    Port ( clk          : in  STD_LOGIC;                      --main input clock 50MHz
           reset        : in  STD_LOGIC;                      --main low active reset
           h_sync       : out STD_LOGIC;                      --VGA horizantal syncronous
           v_sync       : out STD_LOGIC;                      --VGA vertical syncronous
           video_on     : out std_logic;                              --'1' when active video horizentally and vertically
           x_counter    : buffer integer range 0 to 640;
           y_counter    : buffer integer range 0 to 480);
end component;


-------------------------------------------------start_menu
component start_menu is
    Port (  clk			:   in std_logic;
				reset			:   in std_logic;
				x_counter   :   in integer range 0 to 640;
            y_counter   :   in integer range 0 to 480;
            RGB         :   out STD_LOGIC_VECTOR(2 downto 0));  --VGA RGB output
end component;


-------------------------------------------------play_menu
component play_menu is
    Port ( clk              : in  STD_LOGIC;                      --main input clock 50MHz
           reset            : in  STD_LOGIC;                      --main low active reset
           button_left      : in  std_logic;
           button_right     : in  std_logic;
           start_button  	 : in  std_logic;
           x_counter        : in  integer range 0 to 640;
           y_counter        : in  integer range 0 to 480;
			  ball_y 			 : buffer integer range 0 to 480;
           RGB              : out STD_LOGIC_VECTOR(2 downto 0));  --VGA RGB outputend component;
end component;

			 
-------------------------------------------------gameover_menu
component gameover_menu is
    Port (    clk             :      in std_logic;
               reset       :      in std_logic;
               x_counter   :      in integer range 0 to 640;
               y_counter   :       in integer range 0 to 480;
               RGB         :       out STD_LOGIC_VECTOR(2 downto 0));  --VGA RGB output
end component;


-------------------------------------------------RGB_mux
component RGB_mux is
    Port ( clk          : in  STD_LOGIC;
           reset        : in  STD_LOGIC;
           start_button : in  STD_LOGIC;
           rgb_start    : in  STD_LOGIC_vector(2 downto 0);
           rgb_play     : in  STD_LOGIC_vector(2 downto 0);
           rgb_gameover : in  STD_LOGIC_vector(2 downto 0);
           video_on     : in  STD_LOGIC;
           ball_y       : in integer range 0 to 480;
           RGB          : out  STD_LOGIC_vector(2 downto 0));
end component;


--------------------------------------------------------------------------------
signal x_counter : integer range 0 to 640;
signal y_counter : integer range 0 to 480;

signal video_on  : std_logic;

signal rgb_start 		: std_logic_vector(2 downto 0);
signal rgb_play 		: std_logic_vector(2 downto 0);
signal rgb_gameover	: std_logic_vector(2 downto 0);

signal ball_y 			: integer range 0 to 480;

begin
-------------------------------------------------PORT MAP
-------------------------------------------------U1 sync_module
	U1 : sync_module PORT MAP (  	clk 			=> clk,
											reset			=> reset,
											h_sync		=> h_sync,       
											v_sync		=> v_sync,       
											video_on 	=> video_on,     
											x_counter	=> x_counter,    
											y_counter	=> y_counter);
											
											
-------------------------------------------------U2 start_menu
    U2 : start_menu PORT MAP( clk 			=> clk,
										reset			=> reset,
										x_counter 	=> x_counter,
										y_counter	=>	y_counter,
										RGB			=>	rgb_start);
										
										
-------------------------------------------------U3 play_menu
    U3 : play_menu PORT MAP(	clk 				=>		clk,
										reset				=>		reset,
										button_left		=>		button_left,
										button_right	=>		button_right,
										start_button	=>		start_button,
										x_counter		=>		x_counter,
										y_counter		=>		y_counter,
										ball_y 			=>		ball_y,
										RGB				=>		rgb_play);
										
										
-------------------------------------------------U4 gameover_menu
    U4 : gameover_menu PORT MAP(	clk 				=>		clk,
											reset				=>		reset,
											x_counter 		=>		x_counter,
											y_counter  		=>		y_counter,
											RGB			  	=>		rgb_gameover);
											
											
-------------------------------------------------U5 RGB_mux
    U5 : RGB_mux PORT MAP(	clk				=> 	clk,
									reset 			=>		reset,
									start_button	=>		start_button,
									rgb_start		=>		rgb_start,
									rgb_play			=>		rgb_play,
									rgb_gameover	=>		rgb_gameover,
									video_on			=>		video_on,
									ball_y			=>		ball_y,
									RGB				=>		RGB);

end Behavioral;