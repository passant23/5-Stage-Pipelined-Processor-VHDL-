library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.FU_pkg.all;

Entity ForwardingUnit is 
	port (  fu_I : in fu_in; 
		fu_O : out fu_out;
		clk :in std_logic
		);
end entity ForwardingUnit;

architecture FU_arch of ForwardingUnit is
signal EX_Hazard_A : std_logic := '0';
signal MEM_Hazard_A : std_logic := '0';
signal EX_Hazard_B : std_logic := '0';
signal MEM_Hazard_B : std_logic := '0';
begin
  --process (clk)
    --begin 

   -- if fu_I.RegWrite_ExMem='1' and  fu_I.RegDst_ExMem = fu_I.RegDst and rising_edge(clk) then
--    EX_Hazard_A <= '1';
--    else EX_Hazard_A <= '0';
--    end if;  
--      
--    if fu_I.RegWrite_MemWb='1' and rising_edge(clk) and ( fu_I.RegDst_MemWb = fu_I.RegDst and (EX_Hazard_A='0')) then
--    MEM_Hazard_A <= '1';
--    else MEM_Hazard_A <= '0';
--    end if;  
--    
--    if  fu_I.RegSelect='1' and rising_edge(clk) and fu_I.RegWrite_ExMem='1' and  fu_I.RegDst_ExMem=fu_I.RegSrc  then
--    EX_Hazard_B <= '1';
--    else EX_Hazard_B <= '0';
--    end if;
--    
--    if  fu_I.RegSelect='1' and rising_edge(clk) and fu_I.RegWrite_MemWb='1' and ( fu_I.RegDst_MemWb = fu_I.RegSrc) then
--    MEM_Hazard_B <= '1'; 
--    else MEM_Hazard_B <= '0'; 
--    end if;
--    
--    if   EX_Hazard_A='1' then
--    fu_O.ForwardA <= "10";
--    elsif MEM_Hazard_A='1' then
--    fu_O.ForwardA <= "01";
--    else fu_O.ForwardA <= "00";
--    end if;
--      
--    if   EX_Hazard_B='1' then
--    fu_O.ForwardB <= "10";
--    elsif MEM_Hazard_B='1' then
--    fu_O.ForwardB <= "01";
--    else fu_O.ForwardB <= "00";
--    end if;  
       
	EX_Hazard_A <= '1' when (fu_I.RegWrite_ExMem='1' and  fu_I.RegDst_ExMem = fu_I.RegDst) --(forward from ALU to ALU)
			else '0';
	MEM_Hazard_A <= '1' when (fu_I.RegWrite_MemWb='1' and ( fu_I.RegDst_MemWb = fu_I.RegDst ) and (EX_Hazard_A='0')) --(MEM to ALU)
			else '0';
	EX_Hazard_B <= '1' when (fu_I.RegSelect='1' and fu_I.RegWrite_ExMem='1' and  fu_I.RegDst_ExMem=fu_I.RegSrc ) --(forward from ALU to ALU)
			else '0';
	MEM_Hazard_B <= '1' when (fu_I.RegSelect='1' and fu_I.RegWrite_MemWb='1' and ( fu_I.RegDst_MemWb = fu_I.RegSrc ) and (EX_Hazard_B='0') )--(forward from MEM to ALU)
			else '0';

   	fu_O.ForwardA <= "10" when EX_Hazard_A='1' else --overwrite ALU data
        	"01" when MEM_Hazard_A='1'  --overwrite WB data		
		 else    "00";     
        	                                --take original reg data
			
   	fu_O.ForwardB <= "10" when EX_Hazard_B='1' else 
        	"01" when MEM_Hazard_B='1'
else "00";
		
		
		
		--end process;
end architecture FU_arch;