      library ieee;
      use ieee.std_logic_1164.all;
      use ieee.std_logic_arith.all;

      -- This is the entity part.  It describes the inputs and
      -- outputs.   

      entity Lab2A is
         port(	
		SW : in std_logic_vector(3 downto 0);  
		HEX0 : out std_logic_vector(6 downto 0));  
      end Lab1A ;

      architecture structural of Lab12A is
		
		component ssg
      port (s : in std_logic_vector(3 downto 0);hexout : out std_logic_vector(6 downto 0));
   end component;
		
		begin
		     
u0:ssg port map(SW(3 downto 0), HEX0 );
              
      end structural;