
-- VHDL Instantiation Created from source file sync_module.vhd -- 16:54:49 11/28/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT sync_module
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;          
		h_sync : OUT std_logic;
		v_sync : OUT std_logic;
		video_on : OUT std_logic;
		x_counter : OUT std_logic_vector(0 to 9);
		y_counter : OUT std_logic_vector(0 to 8)
		);
	END COMPONENT;

	Inst_sync_module: sync_module PORT MAP(
		clk => ,
		reset => ,
		h_sync => ,
		v_sync => ,
		video_on => ,
		x_counter => ,
		y_counter => 
	);


