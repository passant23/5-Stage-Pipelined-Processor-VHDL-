Library ieee;
Library work;
use ieee.std_logic_1164.all;
use work.buffer_package.all;

entity buffer_MW is
  port( 
    clk,reset,en:in std_logic;
  buffer_MW_in:in buffer_memory_wb;
  buffer_MW_out:out buffer_memory_wb
  
  );
  end buffer_MW;
  architecture buffer_MW_arch of buffer_MW is
    
    begin
     PROCESS(clk,reset)
      BEGIN
        IF reset ='1' THEN 
    --decode outputs    
    
     buffer_MW_out.read_data1<= (OTHERS => '0');
   
   --execute stage outputs
    buffer_MW_out.alu_output<= (OTHERS => '0');--check
    --alu_CCR: std_logic_vector(2 downto 0); --check
    buffer_MW_out.imm_extended<= (OTHERS => '0');
    buffer_MW_out.rdst1<= (OTHERS => '0');
    buffer_MW_out.rdst2<= (OTHERS => '0');
    --memory stage output
    buffer_MW_out.memory_output<= (OTHERS => '0');
    ----- control unit signals --------
   
    --WB signals
    buffer_MW_out.MEM_TO_REG<= (OTHERS => '0');
      
        
        ELSIF  falling_edge(clk) THEN
          if en ='1' then
            buffer_MW_out <= buffer_MW_in;
          end if;
        end if;
      end process;
      
      
      
      
      
    end architecture;






