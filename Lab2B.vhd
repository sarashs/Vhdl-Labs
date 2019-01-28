      library ieee;
      use ieee.std_logic_1164.all;
      use ieee.std_logic_arith.all;

      -- This is the entity part.  It describes the inputs and
      -- outputs.   

      entity Lab2B is
         port(	
		SW : in std_logic_vector(5 downto 0);  
		HEX0 : out std_logic_vector(6 downto 0);
		HEX1 : out std_logic_vector(6 downto 0);
		LEDR : out std_logic_vector(3 downto 0));  
      end Lab2B ;

      architecture structural of Lab2B is
		signal s0, s1, s2, s3: std_logic_VECTor(3 downto 0);
		signal bcd0, bcd1, bcd2: std_logic_vector(3 downto 0);
		component converter1
			port(
		input : in std_logic_vector(3 downto 0);
		bcd1,bcd2 : OUT STD_LOGIC_VECTOR(3 downto 0));
   end component;
			component shifter
			port(
		input : in std_logic_vector(3 downto 0);
		a0, a1, a2, a3 : OUT STD_LOGIC_VECTOR(3 downto 0));
   end component;
		component ssg
      port (s : in std_logic_vector(3 downto 0);hexout : out std_logic_vector(6 downto 0));
   end component;
			component Mux4a
      port (a3, a2, a1, a0 : in std_logic_vector(3 downto 0);	s : in std_logic_vector( 1 downto 0 ); -- one-hot select
	b : out std_logic_vector(3 downto 0) );
   end component;
		
		begin
v0:shifter port map(SW(3 downto 0),s0,s1,s2,s3);
v1:Mux4a port map(s3,s2,s1,s0,SW(5 downto 4),bcd0);
v2:converter1 port map(bcd0,bcd1,bcd2);
LEDR <= bcd0;		     
u0:ssg port map(bcd1, HEX0 );
u1:ssg port map(bcd2, HEX1 );

              
      end structural;
		
      library ieee;
      use ieee.std_logic_1164.all;

		entity shifter is
			port(
		input : in std_logic_vector(3 downto 0);
		a0, a1, a2, a3 : OUT STD_LOGIC_VECTOR(3 downto 0));
		end shifter;
		architecture shift_behave of shifter is
		begin
			a0 <= input;
			a1 <= input(2 downto 0) & input(3 downto 3);
			a2 <= input(1 downto 0) & input(3 downto 2);
			a3 <= input(0 downto 0) & input(3 downto 1);
		end shift_behave;
		
		      library ieee;
      use ieee.std_logic_1164.all;

		entity converter1 is
			port(
		input : in std_logic_vector(3 downto 0);
		bcd1, bcd2 : OUT STD_LOGIC_VECTOR(3 downto 0));
		end converter1;
		architecture converter1_behave of converter1 is
		begin
		   with input select
			bcd1 <= "0000" when "0000",
			 "0001" when "0001",
			 "0010" when "0010",
			 "0011" when "0011",            
			 "0100" when "0100",
			 "0101" when "0101",
			 "0110" when "0110",
			 "0111" when "0111",
			 "1000" when "1000",
			 "1001" when "1001",
			 "0000" when "1010",
			 "0001" when "1011",
			 "0010" when "1100",            
			 "0011" when "1101",
			 "0100" when "1110",
			 "0101" when "1111";	
				   with input select
			bcd2 <= "0000" when "0000",
			 "0000" when "0001",
			 "0000" when "0010",
			 "0000" when "0011",            
			 "0000" when "0100",
			 "0000" when "0101",
			 "0000" when "0110",
			 "0000" when "0111",
			 "0000" when "1000",
			 "0000" when "1001",
			 "0001" when "1010",
			 "0001" when "1011",
			 "0001" when "1100",            
			 "0001" when "1101",
			 "0001" when "1110",
			 "0001" when "1111";		 
		end converter1_behave;