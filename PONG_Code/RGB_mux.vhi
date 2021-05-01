
-- VHDL Instantiation Created from source file RGB_mux.vhd -- 16:53:52 11/28/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT RGB_mux
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		start_button : IN std_logic;
		rgb_start : IN std_logic_vector(2 downto 0);
		rgb_play : IN std_logic_vector(2 downto 0);
		rgb_gameover : IN std_logic_vector(2 downto 0);
		video_on : IN std_logic;
		ball_y : IN std_logic_vector(0 to 8);          
		RGB : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	Inst_RGB_mux: RGB_mux PORT MAP(
		clk => ,
		reset => ,
		start_button => ,
		rgb_start => ,
		rgb_play => ,
		rgb_gameover => ,
		video_on => ,
		ball_y => ,
		RGB => 
	);


