 library ieee;
      use ieee.std_logic_1164.all;
		      entity LAB4 is
         port(
		-- slide switches	
		sw : in std_logic_vector(0 downto 0);  
		-- Key-0
		key : in std_logic_vector(1 downto 0);
		-- LED-0
		ledr : out std_logic_vector(9 downto 0)
		
	);  
      end LAB4 ;
		architecture behav of lab4 is
		type state is (z,o,oo,ooz,oozz,oozzz,oz,ozz,ozzz,ozzzo);
		signal sys_state: state;
		begin
Stateprocess:	process(key(0))
		begin
		if (KEY(0)'event and key(0)='0') then
			if (key(1)='0') then
				sys_state<=z;
			end if;
			case sys_state is
			when z => if sw(0) ='0' then
			sys_state <= z;
			else
			sys_state <= o;
			end if;
			when o => if sw(0) ='0' then
			sys_state <= oz;
			else
			sys_state <= oo;
			end if;
			when oo => if sw(0) ='0' then
			sys_state <= ooz;
			else
			sys_state <= oo;
			end if;
			when ooz => if sw(0) ='0' then
			sys_state <= oozz;
			else
			sys_state <= o;
			end if;
			when oozz => if sw(0) ='0' then
			sys_state <= oozzz;
			else
			sys_state <= o;
			end if;
			when oozzz => sys_state <= z;
			when oz => if sw(0) ='0' then
			sys_state <= ozz;
			else
			sys_state <= o;
			end if;
			when ozz => if sw(0) ='0' then
			sys_state <= ozzz;
			else
			sys_state <= o;
			end if;
			when ozzz => if sw(0) ='0' then
			sys_state <= z;
			else
			sys_state <= ozzzo;
			end if;
			when ozzzo => sys_state <= z;
			end case;
		end if;
		end process;
outputprocess: process(sys_state)
		begin
				case sys_state is
				when oozzz => ledr<="0000000001";
				when ozzzo => ledr<="0000000001";
				when others => ledr<="0000000000";
				end case;
		end process;
		end behav;