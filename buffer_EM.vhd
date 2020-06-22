Library ieee;
Library work;
use ieee.std_logic_1164.all;
use work.buffer_package.all;

entity buffer_EM is
  port( 
    clk,reset,en:in std_logic;
  buffer_EM_in:in buffer_execute_memory;
  buffer_EM_out:out buffer_execute_memory
  
  );
  end buffer_EM;
  architecture buffer_EM_arch of buffer_EM is
    
    begin
     PROCESS(clk,reset)
      BEGIN
        IF reset ='1' THEN 
    --decode outputs    
     buffer_EM_out.pc<= (OTHERS => '0');
     buffer_EM_out. rsc1<= (OTHERS => '0');
     buffer_EM_out.rsc2<= (OTHERS => '0');
     buffer_EM_out.read_data1<= (OTHERS => '0');
     buffer_EM_out.read_data2 <= (OTHERS => '0');
     buffer_EM_out.instruction_bits<= (OTHERS => '0');
	 
   --execute stage outputs
    buffer_EM_out.alu_output<= (OTHERS => '0');--check
    buffer_EM_out.alu_CCR<= (OTHERS => '0');--check
    buffer_EM_out.imm_extended<= (OTHERS => '0');
    buffer_EM_out.rdst1<= (OTHERS => '0');
    buffer_EM_out.rdst2<= (OTHERS => '0');
    buffer_EM_out.outjump<='0';
    ----- control unit signals --------
   
    --memory signals
    buffer_EM_out.Sp_Value 	<= '0';
    buffer_EM_out.SP_MUX1	<= '0';
    buffer_EM_out.SP_MUX2	<= '0';
    buffer_EM_out.callornot<= '0';
    buffer_EM_out.MEM_READ	<= '0';
    buffer_EM_out.MEM_WRITE	<= '0';
    buffer_EM_out.StackAdd_EA<= '0';
    -----------------------------
    --WB signals
    buffer_EM_out.MEM_TO_REG<= (OTHERS => '0');
      
        
        ELSIF  falling_edge(clk) THEN
          if en ='1' then
            buffer_EM_out <= buffer_EM_in;
          end if;
        end if;
      end process;
      
      
      
      
      
    end architecture;




