
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--FPGA pin decleration        
entity sync_module is
    Port ( clk    		: in  STD_LOGIC;                      --main input clock 50MHz
           reset  		: in  STD_LOGIC;                      --main low active reset
           h_sync 		: out STD_LOGIC;                      --VGA horizantal syncronous
           v_sync 		: out STD_LOGIC;                      --VGA vertical syncronous
           video_on		: out std_logic;							  --'1' when active video horizentally and vertically
			  x_counter    :  buffer integer range 0 to 640;
			  y_counter		:	buffer integer range 0 to 480);
			  
end sync_module;


Architecture Behavioral of sync_module is

    -- resolation 640X480,60MHz : pixel clock 25.175MHz
    --                 Active video   Front Porch   Sync Porch  Back Porch   Total
    -- Pixels        :     640              16         96         48          800
    -- Lines         :     480              11          2         31          524
    signal x_counter_sync : integer range 0 to 800; --count the pixels
    signal y_counter_sync : integer range 0 to 525; --count the lines

begin

------------------------------------------------------Generate V/H syncronous-------------------------------------
    process(clk,reset)
        variable x_counter_div : integer range 0 to 2;   --Generate 25MHz for desired resolation 640X480,60MHz : 25.175MHz pixel clock
        variable x_counter_var : integer range 0 to 800; --Variable for count the Pixel
        variable y_counter_var : integer range 0 to 525; --Variable for count the Lines
    begin
        if(reset = '1') then --low active reset
            x_counter_div := 0;
            x_counter_var := 0;
            y_counter_var := 0;
            
        elsif(clk'event and clk = '1') then
            x_counter_div := x_counter_div + 1; --Time divition : 25MHz
                if(x_counter_div = 2) then 
                    x_counter_div := 0;
                    x_counter_var := x_counter_var + 1;
                end if;

                if(x_counter_var = 799) then --reset main counter x
                    x_counter_var := 0;
                    y_counter_var := y_counter_var + 1;
                end if;
                
                if(y_counter_var = 524) then --reset main counter y
                    y_counter_var := 0;
                end if;
        
        end if;
        
    x_counter_sync <= x_counter_var; --Assign var pixel to global Pixel counter
    y_counter_sync <= y_counter_var; --Assign var line  to global Line  counter

    x_counter <= (x_counter_var - 47); --Assign var pixel to global Pixel counter
    y_counter <= (y_counter_var - 32); --Assign var line  to global Line  counter
    end process;
-----------------------------------------------------------------------------------------------------------------
    h_sync   <= '1' when(x_counter_sync >= 0  and x_counter_sync <= 703) else '0'; --output H_syncronous
    v_sync   <= '1' when(y_counter_sync >= 0  and y_counter_sync <= 522) else '0'; --output V_syncronous                                                    
    video_on <= '1' when(y_counter 		 >= 0  and y_counter 	  <= 479  and x_counter >= 0 and x_counter <= 639) else '0';  --video on signal


end Behavioral;

