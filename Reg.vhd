Library ieee;
use ieee.std_Logic_1164.all;

ENTITY reg is 
  GENERIC (n:integer :=32);
  PORT (Clk,Rst,En: IN std_logic;
    d: IN std_logic_vector (n-1 DOWNTO 0);
    q: OUT std_logic_vector(n-1 DOWnTO 0));
  END reg;
  
  ARCHITECTURE reg_arch OF reg
  IS 
  BEGIN
    PROCESS(Clk,Rst)
      BEGIN
        IF Rst ='1' THEN
          q <= (OTHERS => '0');
        ELSIF  rising_edge(Clk) THEN
          if En ='1' then
            q <= d;
          end if;
        end if;
      end process;
    End reg_arch;
    
          
            
  