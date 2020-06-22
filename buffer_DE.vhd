Library ieee;
Library work;
use ieee.std_logic_1164.all;
use work.buffer_package.all;

entity buffer_DE is
  port( 
    clk,reset,en:in std_logic;
  buffer_DE_in:in buffer_decode_execute;
  buffer_DE_out:out buffer_decode_execute
  
  );
  end buffer_DE;
  architecture buffer_DE_arch of buffer_DE is
    
    begin
     PROCESS(clk,reset)
      BEGIN
        IF reset ='1' THEN 
    --decode outputs    
     buffer_DE_out.pc<= (OTHERS => '0');
     buffer_DE_out. rsc1<= (OTHERS => '0');
     buffer_DE_out.rsc2<= (OTHERS => '0');
     buffer_DE_out.read_data1<= (OTHERS => '0');
     buffer_DE_out.read_data2 <= (OTHERS => '0');
     buffer_DE_out.instruction_bits<= (OTHERS => '0');
    
    ----- control unit signals --------
    --decode signals
    buffer_DE_out.REG_WRITE	<= '0';
    buffer_DE_out.REG_WRITE2 <= '0';
    ---------------------------
    --execute signals
    buffer_DE_out.MUX_EXTEND<= (OTHERS => '0');
    buffer_DE_out.ALUSEL	<= (OTHERS => '0');
    buffer_DE_out.RDST_sel	<= (OTHERS => '0');
    buffer_DE_out.ZNC	<= (OTHERS => '0');
    buffer_DE_out.CCR_Enable<= '0';
   	buffer_DE_out.branch_bit	<= '0';
   	buffer_DE_out.PoppedorNot<= '0';
   	---------------------------
    --memory signals
    buffer_DE_out.Sp_Value 	<= '0';
    buffer_DE_out.SP_MUX1	<= '0';
    buffer_DE_out.SP_MUX2	<= '0';
    buffer_DE_out.callornot<= '0';
    buffer_DE_out.MEM_READ	<= '0';
    buffer_DE_out.MEM_WRITE	<= '0';
    buffer_DE_out.StackAdd_EA<= '0';
    -----------------------------
    --WB signals
    buffer_DE_out.MEM_TO_REG<= (OTHERS => '0');
      
        
        ELSIF  falling_edge(clk) THEN
          if en ='1' then
            buffer_DE_out <= buffer_DE_in;
          end if;
        end if;
      end process;
      
      
      
      
      
    end architecture;



