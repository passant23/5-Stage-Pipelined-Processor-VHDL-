Library ieee;
Library work;
use ieee.std_logic_1164.all;
use work.buffer_package.all;

entity buffer_FD is
  port( 
    clk,reset,en:in std_logic;
  buffer_FD_in:in buffer_fetch_decode;
  buffer_FD_out:out buffer_fetch_decode
  
  );
  end buffer_FD;
  architecture buffer_FD_arch of buffer_FD is
    
    begin
      
       PROCESS(clk,reset)
      BEGIN
        IF reset ='1' THEN 
          buffer_FD_out.pc<= (OTHERS => '0'); 
         -- buffer_FD_out.instruction_bits <= (OTHERS => '0');
        ELSIF  falling_edge(clk) THEN
          if en ='1' then
            buffer_FD_out <= buffer_FD_in;
          end if;
        end if;
      end process;
      
      
      
      
      
    end architecture;

