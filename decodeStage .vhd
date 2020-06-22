Library ieee;
Use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
use work.buffer_package.all;
use work.decode_package.all;

ENTITY ID_stage IS 
PORT(clk,rst : IN std_logic;
    --R: OUT decode_in;
     Rout : OUT decode_out;
     input_fetch : IN buffer_fetch_decode;
     regWrite1, regWrite2 : IN std_logic;
     input_memory : IN buffer_memory_wb;
     input_data_wb : IN std_logic_vector(31 DOWNTO 0) --from write back stage
     );
END ENTITY;

ARCHITECTURE ID_arch OF ID_stage IS

COMPONENT RegFile IS
PORT(clk,rst : IN std_logic;
     register_input : IN decode_in;
     register_output : OUT decode_out
  );
 END COMPONENT;
 
 SIGNAL data : decode_out;
 SIGNAL instruction : std_logic_vector( 0 TO 31);
 --SIGNAL dataOutput : decode_out;
 SIGNAL inputRegister : decode_in;
  
 BEGIN
  
   
 
 inputRegister.regWrite1 <= input_memory.REG_WRITE;
 inputRegister.regWrite2 <= input_memory.REG_WRITE2;
 
 instruction <= input_fetch.instruction_bits;
  
 inputRegister.Rsrc1 <= instruction(6 TO 8);
 inputRegister.Rsrc2 <= instruction(9 TO 11);
 inputRegister.Rdst1 <= input_memory.rdst1;

process(clk)
  begin
    if rising_edge(clk) then
 inputRegister.dataDst1 <= input_data_wb;
  Rout.data1 <= data.data1;
  Rout.data2 <= data.data2;

 end if;
 end process;


  Rout.rsc1 <= instruction(6 TO 8);
  Rout.rsc2 <= instruction(9 TO 11);
  Rout.rsc3 <= instruction(12 TO 14);
  ---dataOutput.instruction_bits <= instruction(9 to 28); --20 bit effective address
  --dataOutput.imm_5 <= instruction(9 to 13);
  --dataOutput.imm_16 <= instruction(9 to 24); --will be edited in 2 operands
  --dataOutput.REG_WRITE <= regWrite1;
  --dataOutput.REG_WRITE2 <= regWrite2;
  --dataOutput.pc <= input_fetch.pc;
  
  
--R <= inputRegister ; 
  
 regFileObject : RegFile PORT MAP(clk,rst,inputRegister,data);





END ID_arch;