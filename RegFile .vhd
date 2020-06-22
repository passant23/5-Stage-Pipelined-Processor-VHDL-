Library ieee;
Use ieee.std_logic_1164.all;
use work.buffer_package.all;
use work.decode_package.all;

ENTITY RegFile IS
PORT(clk,rst : IN std_logic;
     register_input : IN decode_in;
     register_output : OUT decode_out
  );
END ENTITY;

ARCHITECTURE archRegFile OF RegFile IS
  
  COMPONENT dFlipFlop IS
       PORT( clk,rst,enable : IN std_logic;
		         input : IN std_logic_vector(31 DOWNTO 0);
		         output : OUT std_logic_vector(31 DOWNTO 0));
  END COMPONENT;
  
  COMPONENT Decoder IS  --to select one of the 8 registers
  PORT( sel : IN std_logic_vector (2 DOWNTO 0);
		    rst,enable : IN std_logic;
		    output : OUT std_logic_vector(7 DOWNTO 0));
  END COMPONENT;
  SIGNAL regEnable1 : std_logic_vector(7 DOWNTO 0);
  SIGNAL regEnable2 : std_logic_vector(7 DOWNTO 0);
  SIGNAL regEnable : std_logic_vector(7 DOWNTO 0); --what will determine which register will work
  SIGNAL input1, input2,input3, input4, input5,input6,input7,input8 : std_logic_vector(31 DOWNTO 0); --input signals for each of the 8 Dflipflops (Registers)
  SIGNAL output1, output2, output3, output4, output5, output6, output7, output8 : std_logic_vector(31 DOWNTO 0); --output signals for each of the 8 Dflipflops (Registers)
  
  BEGIN
    
    write1Decoder : Decoder PORT MAP(register_input.Rdst1,rst,register_input.regWrite1,regEnable1);
    write2Decoder : Decoder PORT MAP(register_input.Rdst2,rst,register_input.regWrite2, regEnable2);
    
    regEnable  <= "00000000" WHEN  register_input.regWrite1 = '0' AND register_input.regWrite2 = '0' ELSE 
                  regEnable1 WHEN  register_input.regWrite1 = '1' AND register_input.regWrite2 = '0' ELSE
                  regEnable2 WHEN  register_input.regWrite1 = '0' AND register_input.regWrite2 = '1' ELSE
                  regEnable2 OR regEnable1;
               
    r0 : dFlipFlop PORT MAP(clk, rst, regEnable(0),input1, output1);
    r1 : dFlipFlop PORT MAP(clk, rst, regEnable(1),input2, output2);
    r2 : dFlipFlop PORT MAP(clk, rst, regEnable(2),input3, output3);
    r3 : dFlipFlop PORT MAP(clk, rst, regEnable(3),input4, output4);
    r4 : dFlipFlop PORT MAP(clk, rst, regEnable(4),input5, output5);
    r5 : dFlipFlop PORT MAP(clk, rst, regEnable(5),input6, output6);
    r6 : dFlipFlop PORT MAP(clk, rst, regEnable(6),input7, output7);
    r7 : dFlipFlop PORT MAP(clk, rst, regEnable(7),input8, output8);
    
  
    
     input1 <= register_input.dataDst1 WHEN  register_input.Rdst1="000" AND register_input.regWrite1='1'
          ELSE register_input.dataDst2 WHEN  register_input.Rdst2="000" AND register_input.regWrite2='1';
            
     input2 <= register_input.dataDst1 WHEN  register_input.Rdst1="001" AND register_input.regWrite1='1'
          ELSE register_input.dataDst2 WHEN  register_input.Rdst2="001" AND register_input.regWrite2='1';
           
     input3 <= register_input.dataDst1 WHEN  register_input.Rdst1="010" AND register_input.regWrite1='1'
          ELSE register_input.dataDst2 WHEN  register_input.Rdst2="010" AND register_input.regWrite2='1';
          
     input4 <= register_input.dataDst1 WHEN  register_input.Rdst1="011" AND register_input.regWrite1='1'
          ELSE register_input.dataDst2 WHEN  register_input.Rdst2="011" AND register_input.regWrite2='1';
            
     input5 <= register_input.dataDst1 WHEN  register_input.Rdst1="100" AND register_input.regWrite1='1'
          ELSE register_input.dataDst2 WHEN  register_input.Rdst2="100" AND register_input.regWrite2='1';
            
     input6 <= register_input.dataDst1 WHEN  register_input.Rdst1="101" AND register_input.regWrite1='1'
          ELSE register_input.dataDst2 WHEN  register_input.Rdst2="101" AND register_input.regWrite2='1';
            
     input7 <= register_input.dataDst1 WHEN  register_input.Rdst1="110" AND register_input.regWrite1='1'
          ELSE register_input.dataDst2 WHEN  register_input.Rdst2="110" AND register_input.regWrite2='1';
      
     input8 <= register_input.dataDst1 WHEN  register_input.Rdst1="111" AND register_input.regWrite1='1'
          ELSE register_input.dataDst2 WHEN  register_input.Rdst2="111" AND register_input.regWrite2='1';
    
     register_output.data1 <= output1 WHEN register_input.Rsrc1="000" 
         ELSE output2 WHEN register_input.Rsrc1="001"  
         ELSE output3 WHEN register_input.Rsrc1="010" 
         ELSE output4 WHEN register_input.Rsrc1="011"
         ELSE output5 WHEN register_input.Rsrc1="100" 
         ELSE output6 WHEN register_input.Rsrc1="101" 
         ELSE output7 WHEN register_input.Rsrc1="110" 
         ELSE output8 WHEN register_input.Rsrc1="111";
           
          
     register_output.data2 <= output1 WHEN register_input.Rsrc2="000" 
         ELSE output2 WHEN register_input.Rsrc2="001"  
         ELSE output3 WHEN register_input.Rsrc2="010" 
         ELSE output4 WHEN register_input.Rsrc2="011"
         ELSE output5 WHEN register_input.Rsrc2="100" 
         ELSE output6 WHEN register_input.Rsrc2="101" 
         ELSE output7 WHEN register_input.Rsrc2="110" 
         ELSE output8 WHEN register_input.Rsrc2="111";  
           
           
    
END archRegFile;

