 library ieee;
      use ieee.std_logic_1164.all;
		      entity LAB3 is
         port(
		-- slide switches	
		sw : in std_logic_vector(1 downto 0);  

		-- 7-segment display
		--hex0 : out std_logic_vector(6 downto 0);
		-- Key-0
		key : in std_logic;
		-- LED-0
		ledr : out std_logic;
		HEX0 : out std_logic_vector(6 downto 0);
				-- clk
		max10_clk1_50 : in std_logic
		
	);  
      end LAB3 ;
		architecture lab3struct of lab3 is
		component counter is
			generic( n: integer := 49999999 );
          Port( clk : in std_logic;
                reset : in std_logic;
                clko : out std_logic);
		end component;
component mux is
          Port( i0 : in std_logic;
              i1 : in std_logic;
              i2 : in std_logic;
              i3 : in std_logic;
              s : in std_logic_vector(1 downto 0);
              o : out std_logic;
				  bcd0 : out std_logic_vector(3 downto 0));
end component;
component ssg
      port (s : in std_logic_vector(3 downto 0);hexout : out std_logic_vector(6 downto 0));
end component;
         signal clko1:std_logic;
         signal clko2:std_logic;
         signal clko3:std_logic;
         signal clko4:std_logic;
         signal o:std_logic;
			signal ledsig:std_logic;
			signal bcd0 : std_logic_vector(3 downto 0);
		begin
		  d1:counter generic map(49999999) port map(max10_clk1_50,KEY,clko1);
        d2:counter generic map(25999999) port map(max10_clk1_50,KEY,clko2);
        d3:counter generic map(12599999) port map(max10_clk1_50,KEY,clko3);
        d4:counter generic map(4999999) port map(max10_clk1_50,KEY,clko4);
        m1:mux port map(clko1,clko2,clko3,clko4,SW,o,bcd0);
		  ssg1: ssg port map(bcd0, hex0);
		  ledr<=ledsig;
		  process(key,o)
		  begin
		  --asynchronous reset
		  if (KEY='0') then
			ledsig<='0';
			else
				if (o' event and o='1') then
					ledsig<= not ledsig;
				end if;
		  end if;
		  end process; 
		end lab3struct;
		
library ieee;
use ieee.std_logic_1164.all;	
		entity mux is
          port( i0 : in std_logic;
              i1 : in std_logic;
              i2 : in std_logic;
              i3 : in std_logic;
              s : in std_logic_vector(1 downto 0);
              o : out std_logic;
				  bcd0 : out std_logic_vector(3 downto 0));
end mux ;

architecture Behavioral of mux is
begin

   with s select
        o <=  i0 when "00",
                 i1 when "01",
                 i2 when "10",
                 i3 when others;
	with s select
        bcd0 <=  "0001" when "00",
                 "0010" when "01",
                 "0011" when "10",
                 "0100" when others;
end Behavioral;