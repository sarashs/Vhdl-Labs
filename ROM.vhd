library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity ROM is
  generic( data_width: integer := 32; 
           addr_width: integer := 4; 
           filename: string := "dataFile" );
  port( addr: in std_logic_vector(addr_width-1 downto 0);
        data: out std_logic_vector(data_width-1 downto 0) );
end ROM;

architecture impl of ROM is
  subtype word_t is std_logic_vector(data_width-1 downto 0); 
  type mem_t is array(0 to (2**addr_width-1)) of word_t;

  -- ModelSim and Vivado will initialize RAM/ROMs using the following function
  impure function init_rom (filename: in string) return mem_t is
    file init_file: text open read_mode is filename; 
    variable init_line: line;
    variable result_mem: mem_t;
  begin
    for i in result_mem'range loop
      readline(init_file,init_line);
      ieee.std_logic_textio.read(init_line, result_mem(i));
    end loop; 
    return result_mem;
  end init_rom;

  signal rom_data: mem_t := init_rom(filename);
  
  -- Quartus initializes RAM/ROMs via ram_init_file synthesis attribute
  -- filename must be in MIF format (different format than used by init_rom)
  attribute ram_init_file : string;
  attribute ram_init_file of rom_data : signal is filename;
begin
  data <= rom_data(to_integer(unsigned(addr)));
end impl;