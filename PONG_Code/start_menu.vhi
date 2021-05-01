
-- VHDL Instantiation Created from source file start_menu.vhd -- 16:52:08 11/28/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT start_menu
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		x_counter : IN std_logic_vector(0 to 9);
		y_counter : IN std_logic_vector(0 to 8);          
		RGB : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	Inst_start_menu: start_menu PORT MAP(
		clk => ,
		reset => ,
		x_counter => ,
		y_counter => ,
		RGB => 
	);


