Library ieee;
Library work;
use ieee.std_logic_1164.all;
use work.buffer_package.all;
--use work.buffer_MW.all;

entity wb_stage is
  port( 
  wb_d:in buffer_memory_wb;
  
  read_data2:out std_logic_vector (31 downto 0)
  --buffer_out:out buffer_memory_wb
  );
  end entity wb_stage;
  
  Architecture wb of wb_stage is
  begin
    read_data2 <= wb_d.imm_extended when wb_d.MEM_TO_REG ="01" else
                  wb_d.input_port when wb_d.MEM_TO_REG ="10" else
                  wb_d.alu_output when wb_d.MEM_TO_REG ="00" else
                  wb_d.memory_output when wb_d.MEM_TO_REG="11";
				
   -- buffer_out<= wb_d;			
				 
  end wb;