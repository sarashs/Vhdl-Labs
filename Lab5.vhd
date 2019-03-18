library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

-- lab 5 part 2
entity Lab5 is
  
    Port (
    sw     : in  STD_LOGIC_VECTOR(7 downto 0);  --inputs 8-bit
	 ledr   : out  STD_LOGIC_VECTOR(7 downto 0);  --outputs 8-bit
	 key : in std_logic;
	 max10_clk1_50 : in std_logic
    );
end Lab5; 


architecture Behav of Lab5 is

component  ROM is
  generic( data_width: integer := 8; 
           addr_width: integer := 4; 
           filename: string := "dataFile" );
  port( addr: in std_logic_vector(addr_width-1 downto 0);
        data: out std_logic_vector(data_width-1 downto 0) );
end component ;

component  vDFF is
    generic( n: integer := 1 );
    port( clk: in std_logic;
          D: in std_logic_vector( n-1 downto 0 );
          Q: out std_logic_vector( n-1 downto 0 ) );
end component ;

component  ALU is
  
    Port (
    A, B     : in  STD_LOGIC_VECTOR(7 downto 0);  -- 2 inputs 8-bit
    Sel  : in  STD_LOGIC_VECTOR(2 downto 0);  -- 1 input 4-bit for selecting function
    Output   : out  STD_LOGIC_VECTOR(7 downto 0); -- 1 output 8-bit 
    Carryout : out std_logic        -- Carryout flag
    );
end component ; 

signal pn : std_logic_vector (1 downto 0);
signal nxt : std_logic_vector (1 downto 0);
signal ALU_out : std_logic_vector (7 downto 0);
signal temp_key : std_logic_vector (7 downto 0);
signal dontcare : std_logic;
signal s : std_logic_vector (0 downto 0);
signal s1 : std_logic_vector (0 downto 0);
signal s2 : std_logic_vector (0 downto 0);
signal s3 : std_logic_vector (0 downto 0);
signal debounced : std_logic_vector (0 downto 0);

begin
deb1: vDFF generic map(1) port map(max10_clk1_50,s,s1);
deb2: vDFF generic map(1) port map(max10_clk1_50,s1,s2);
deb3: vDFF generic map(1) port map(max10_clk1_50,s2,s3);
memorypointer: vDFF generic map(2) port map(debounced(0),nxt,pn);
readkey: ROM generic map(8, 2, "keys") port map(pn, temp_key);
perform_Addition: ALU port map(sw,temp_key,"111",ALU_out,dontcare);
s(0)<=not key;
debounced<=(not s3) and s2 and s1;
ledr<=ALU_out;
 process(debounced(0))
 begin
 if rising_edge(debounced(0)) then
	if pn = "11" then nxt <= "00";
	else nxt<=pn+'1';end if;
 end if;
 end process;
end Behav;