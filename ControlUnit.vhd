Library ieee;
Library work;
use ieee.std_logic_1164.all;
use work.fetch_package.all;
use work.decode_package.all;
use work.execute_package.all;
use work.memory_package.all;

entity ControlUnit is
port(
--INPUTS-----
opcode: in std_logic_vector(0 to 5); 
stall: in std_logic;
---OUTPUTS-------
--fetching signals--
--------------------
fetchsignals: out fetch_in;
decodesignals:out decode_in;
executesignals:out execute_in;
memorysignals:out memory_in;
wbsignals:out std_logic_vector(1 downto 0);
regop,rsc_sel: out std_logic
--------------------
);
end ControlUnit;
architecture cu_arch of ControlUnit is 
begin
 
fetchsignals.inst_size<='1' when opcode(0)='1'

else '0';
  process(opcode,stall)
    begin
--------------------------------------------------	
-------------ONE OPERAND INSTRUCTIONS-------------
--------------------------------------------------	
 --NOP
 if stall='1'
 then 
  decodesignals.regWrite1<='0' ;
        decodesignals.regWrite2<='0';
		
       executesignals.CCR_Enable<='0';
       executesignals.alu_enable<='0';
       executesignals.alu_sel<="0000";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00";
	   
	  memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='0'; 
	  memorysignals.CallOrNot<='0';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';


       wbsignals<="00";
	   --mem to reg 
  elsif opcode="000000"
   
     then  decodesignals.regWrite1<='0' ;
        decodesignals.regWrite2<='0';
		
       executesignals.CCR_Enable<='0';
       executesignals.alu_enable<='0';
       executesignals.alu_sel<="0000";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00";
	   
	  memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';


       wbsignals<="00";
	   --mem to reg 
	   
	   
	   
elsif opcode="000001" 
  --SETC
  then
     decodesignals.regWrite1<='0';
        decodesignals.regWrite2<='0';
        -------
         executesignals.alu_enable<='0';
       executesignals.CCR_Enable<='1';
       executesignals.alu_sel<="1101";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00";
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
       wbsignals<="00";
    --CLRC
 elsif opcode="000010"
 then
       decodesignals.regWrite1<='0'; 
        decodesignals.regWrite2<='0';
		
       executesignals.CCR_Enable<='1';
        executesignals.alu_enable<='0';
       executesignals.alu_sel<="1110";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00";
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
       wbsignals<="00";
       --NOT
   elsif opcode="000011"
   then
        decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='0';
		
       executesignals.CCR_Enable<='1';
       executesignals.alu_enable<='1';
       executesignals.alu_sel<="0111";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00";
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
       wbsignals<="00";

  --INC 
  elsif opcode="000100"
  then
       decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='1';
       executesignals.alu_enable<='1';
       executesignals.alu_sel<="0110";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00";  

 memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
  wbsignals<="00";
    --DEC
    elsif opcode="000101"
    then
      decodesignals.regWrite1<='1';  
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='1';
       executesignals.alu_sel<="0011";
        executesignals.alu_enable<='1';
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00"; 

 memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';	   
       wbsignals<="00";
	   
       
        --OUT
 elsif opcode="000111"
        then
 decodesignals.regWrite1<='0';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='0';
        executesignals.alu_enable<='0';
       executesignals.alu_sel<="0000";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00";  
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
  wbsignals<="00";
      --IN
        elsif opcode="000110"
        then
       decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='0';
        executesignals.alu_enable<='0';
       executesignals.alu_sel<="0000";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00"; 
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
      wbsignals<="10";
  
 --------------------------------------------------	
-------------TWO OPERAND INSTRUCTIONS-------------
--------------------------------------------------	 
  
 elsif opcode="010000"
    --OR 
     then  decodesignals.regWrite1<='1' ;
        decodesignals.regWrite2<='0';
		
       executesignals.CCR_Enable<='1';
       executesignals.alu_enable<='1';
       executesignals.alu_sel<="0101";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="10";
	   
	  memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';


       wbsignals<="00";
	   --mem to reg 
	   
elsif opcode="010001" 
  --ADD
  then
     decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='0';
        -------
         executesignals.alu_enable<='1';
       executesignals.CCR_Enable<='1';
       executesignals.alu_sel<="0001";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="10";
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
       wbsignals<="00";
    
 elsif opcode="010010"
 --SUB
 then
       decodesignals.regWrite1<='1'; 
        decodesignals.regWrite2<='0';
		
       executesignals.CCR_Enable<='1';
        executesignals.alu_enable<='1';
       executesignals.alu_sel<="0010";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="10";
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
       wbsignals<="00";
     
   elsif opcode="010011"
   --AND
   then
        decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='0';
		
       executesignals.CCR_Enable<='1';
       executesignals.alu_enable<='1';
       executesignals.alu_sel<="0100";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="10";
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
       wbsignals<="00";


  elsif opcode="010100"
    --SHR
  then
       decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='1';
       executesignals.alu_enable<='1';
       executesignals.alu_sel<="1000";
       executesignals.MUX_EXTEND<="10";
       executesignals.rdst_signal<="00";  

 memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
  wbsignals<="00";
 
    elsif opcode="010101"
	--SHL
    then
      decodesignals.regWrite1<='1';  
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='1';
       executesignals.alu_sel<="1100";
        executesignals.alu_enable<='1';
       executesignals.MUX_EXTEND<="10";
       executesignals.rdst_signal<="00"; 

 memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';	   
       wbsignals<="00";
	   
       
      
 elsif opcode="010110"
 --SWAP  ---CHECK?
        then
 decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='1';
       executesignals.CCR_Enable<='0';
        executesignals.alu_enable<='0';
       executesignals.alu_sel<="1111";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00";  
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
  wbsignals<="00";
      
        elsif opcode="110111"
		--IADD
        then
       decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='1';
        executesignals.alu_enable<='1';
       executesignals.alu_sel<="0001";
       executesignals.MUX_EXTEND<="01";
       executesignals.rdst_signal<="01"; 
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
      wbsignals<="00";
  
 --------------------------------------------------	
-------------BRANCHING INSTRUCTIONS-------------
--------------------------------------------------	 
 --JC
 -- change alu enable back to 0
 elsif opcode="001010"
 then 
 
       decodesignals.regWrite1<='0';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='1';
        executesignals.alu_enable<='1';
       executesignals.alu_sel<="1011";
       executesignals.MUX_EXTEND<="01";
       executesignals.rdst_signal<="00"; 
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
      wbsignals<="01";
 
 
 
 --JN
 
 elsif opcode="001001"
 then 
 
       decodesignals.regWrite1<='0';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='1';
        executesignals.alu_enable<='1';
       executesignals.alu_sel<="1010";
       executesignals.MUX_EXTEND<="01";
       executesignals.rdst_signal<="00"; 
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
      wbsignals<="01";
 
 --JZ
 




elsif opcode="001000"
 then 
 
       decodesignals.regWrite1<='0';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='1';
        executesignals.alu_enable<='1';
       executesignals.alu_sel<="1001";
       executesignals.MUX_EXTEND<="01";
       executesignals.rdst_signal<="00"; 
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
      wbsignals<="01";




---JMP
elsif opcode="001011"

 then 
 
       decodesignals.regWrite1<='0';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='0';
        executesignals.alu_enable<='1';
       executesignals.alu_sel<="0000";
       executesignals.MUX_EXTEND<="01";
       executesignals.rdst_signal<="00"; 
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='1'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
      wbsignals<="01";
	  ----------------------------------------------------------
	  --------------------MEMORY INSTRUCTIONS---------------
	  -----------------------------------------------------------
	--LDM
	elsif opcode="111000"


 then 
 
       decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='0';
        executesignals.alu_enable<='0';
       executesignals.alu_sel<="0000";
       executesignals.MUX_EXTEND<="11";
       executesignals.rdst_signal<="00"; 
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='0'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
      wbsignals<="01";  
	  
	  
	  


----------------------
--111001 LDD          
--111110 STD

--LDD
	elsif opcode="111001"


 then 
 
       decodesignals.regWrite1<='1';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='0';
        executesignals.alu_enable<='0';
       executesignals.alu_sel<="0000";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00"; 
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='0'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='1';
	  memorysignals.MemWrite<='0';
	  memorysignals.StackAddEA<='0';
	  
      wbsignals<="11";  
      --STD
	  elsif opcode="111110"


 then 
 
       decodesignals.regWrite1<='0';
        decodesignals.regWrite2<='0';
       executesignals.CCR_Enable<='0';
        executesignals.alu_enable<='0';
       executesignals.alu_sel<="0000";
       executesignals.MUX_EXTEND<="00";
       executesignals.rdst_signal<="00"; 
	   
	    memorysignals.SPValue<='0';
      memorysignals.SPMUX1<='0' ;
      memorysignals.SPMUX2<='0'; 
	  memorysignals.CallOrNot<='1';
	  memorysignals.memRead<='0';
	  memorysignals.MemWrite<='1';
	  memorysignals.StackAddEA<='0';
	  
      wbsignals<="11";  
	  
	  
	  
end if;






 
  

  

end process;

  
  
  
  

--------------------
fetchsignals.Returnornot<='1' when opcode="001101"
else '0';
executesignals.branch_bit<= '1' when opcode="001000" or opcode="001001" or opcode="001010" or opcode="001011" or opcode="001100" or opcode="001101" or opcode="001110"
else '0';

executesignals.popped_or_not<='1' when opcode="001110"
else '0';

executesignals.znc<="01" when opcode="001000"
                  else   "10"  when opcode="001001"
                       else "11"  when opcode="001010"
					  else "00";




regop<= '1' when opcode="010000" or opcode="010001" or opcode="010010" or opcode="010011" or opcode="010100" or opcode="010101" or opcode="010110" or opcode="110111" else
'0';


rsc_sel<='1' when opcode="010000" or opcode="010001" or opcode="010010" or opcode="010011" or opcode="010100" 
else '0';









  
  
  
end architecture;