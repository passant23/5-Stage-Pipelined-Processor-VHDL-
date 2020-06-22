library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package HD_pckg is
    type HD_in is record
  	Next_Stage_Reg : std_logic_vector( 2 downto 0);
	Next_Stage_opcode:std_logic_vector(0 to 5);
	Src_Reg: std_logic_vector(2 downto 0);
 	Dst_Reg: std_logic_vector(2 downto 0);
  	Mem_Read : std_logic;
  	
	Reset : std_logic;
    end record HD_in;

    type HD_out is record
	Stall_cu : std_logic; --for stall
  	
  	Stall : std_logic;
    end record HD_out;

end package HD_pckg;