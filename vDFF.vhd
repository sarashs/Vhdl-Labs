library ieee;
use ieee.std_logic_1164.all;

entity vDFF is
    generic( n: integer := 1 );
    port( clk: in std_logic;
          D: in std_logic_vector( n-1 downto 0 );
          Q: out std_logic_vector( n-1 downto 0 ) );
end vDFF;

architecture impl of vDFF is
begin
  process(clk) begin
    if rising_edge(clk) then
      Q <= D;
    end if;
  end process;
end impl;