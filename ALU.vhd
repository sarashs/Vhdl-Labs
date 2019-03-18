library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;
-- 8-bit ALU with 3 bit selector
entity ALU is
  
    Port (
    A, B     : in  STD_LOGIC_VECTOR(7 downto 0);  -- 2 inputs 8-bit
    Sel  : in  STD_LOGIC_VECTOR(2 downto 0);  -- 1 input 4-bit for selecting function
    Output   : out  STD_LOGIC_VECTOR(7 downto 0); -- 1 output 8-bit 
    Carryout : out std_logic        -- Carryout flag
    );
end ALU; 
architecture Behav of ALU is

signal ALU_out : std_logic_vector (8 downto 0);

begin
   process(A,B,Sel)
 begin
  case(Sel) is
  when "000" => 
   ALU_out <= ('0' & A) + ('0' & B) ; 
  when "001" => 
   ALU_out <= ('0' & A) - ('0' & B) ;
  when "010" => 
   ALU_out <= '0' & std_logic_vector(to_unsigned((to_integer(unsigned(A)) * to_integer(unsigned(B))),8)) ;
  when "011" => 
   ALU_out <= '0' & std_logic_vector(to_unsigned(to_integer(unsigned(A)) / to_integer(unsigned(B)),8)) ;
  when "100" => 
   ALU_out <= A & '0';
  when "101" => 
   ALU_out <= '0' & A and B;
  when "110" => 
   ALU_out <= '0' & A or B;
  when "111" => 
   ALU_out <= '0' & A xor B;
  when others => ALU_out <= ('0' & A) + ('0' & B) ; 
  end case;
 end process;
 Output <= ALU_out(7 downto 0); --Output
 Carryout <= ALU_out(8); -- Carryout flag
end Behav;