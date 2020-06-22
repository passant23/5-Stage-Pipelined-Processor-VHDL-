Library ieee;
use ieee.std_logic_1164.all;


package fetch_package is  
  type fetch_in is record
--fetch stage  inputs
    
inst_size:std_logic;
Returnornot:std_logic;
int_fetch:std_logic;
--M_SP:std_logic_vector(31 downto 0);
Read_data1:std_logic_vector(31 downto 0);
branch_taken:std_logic;

end record;

  type fetch_out is record
    
    --fetch stage outputs
    instruction_bits : std_logic_vector(0 to 31); 
    pc: std_logic_vector (31 downto 0);
end record;



    
  end package;
