Library ieee;
use ieee.std_logic_1164.all;
use work.HD_pckg.all;

entity HDU is
  port(HDU_IN : in HD_in; 
	HDU_OUT : out HD_out
);
end entity HDU;
Architecture a_HDU of HDU is
signal s:std_logic;
  begin
   
  s <= '0' when  HDU_IN.Next_Stage_opcode="000000" or  HDU_IN.Next_Stage_opcode="000001" or HDU_IN.Next_Stage_opcode="000010"
  else  '1'   when (HDU_IN.Mem_Read = '1') and  ( (HDU_IN.Dst_Reg = HDU_IN.Next_Stage_Reg or HDU_IN.Src_Reg = HDU_IN.Next_Stage_Reg)) 
  else '0';

 HDU_OUT.Stall_cu<=s;
 
 
HDU_OUT.Stall<= '0' when  s='1'
else '1';
  
end Architecture a_HDU;