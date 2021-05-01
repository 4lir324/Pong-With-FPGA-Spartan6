
-- VHDL Instantiation Created from source file play_menu.vhd -- 16:52:38 11/28/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT play_menu
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		button_left : IN std_logic;
		button_right : IN std_logic;
		start_button : IN std_logic;
		x_counter : IN std_logic_vector(0 to 9);
		y_counter : IN std_logic_vector(0 to 8);          
		ball_y : OUT std_logic_vector(0 to 8);
		RGB : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	Inst_play_menu: play_menu PORT MAP(
		clk => ,
		reset => ,
		button_left => ,
		button_right => ,
		start_button => ,
		x_counter => ,
		y_counter => ,
		ball_y => ,
		RGB => 
	);


