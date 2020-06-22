Library ieee;
use ieee.std_logic_1164.all;
use work.buffer_package.all;

package execute_package is  
  
  type  execute_in is record
    --read data1 and read data2
data1 : std_logic_vector (31 downto 0);
data2 : std_logic_vector (31 downto 0);
-----FU-------------------------------
fa: std_logic_vector (1 downto 0);
fb: std_logic_vector (1 downto 0);
ALUFU: std_logic_vector (31 downto 0);
MemFU: std_logic_vector (31 downto 0);
--ccr_in: std_logic_vector (3 downto 0);

-----CONTROL UNIT SIGNALS-----------
CCR_Enable:std_logic;   --!!
alu_enable:std_logic;
branch_bit:std_logic;
znc:std_logic_vector(1 downto 0);
popped_or_not:std_logic;
alu_sel:std_logic_vector (3 downto 0);
MUX_EXTEND:std_logic_vector(1 downto 0);
rdst_signal:std_logic_vector(1 downto 0);

------------------------------------

imm_5:std_logic_vector (4 downto 0);
imm_16:std_logic_vector (15 downto 0);
-----Rdst
Rdst_6_8 : std_logic_vector (0 to 2);  --!!
Rdst_9_11 :std_logic_vector (0 to 2);   --!!
Rdst_12_14 :std_logic_vector (0 to 2);   --!!

end record;

  type execute_out is record
    alu_output:std_logic_vector (31 downto 0);
    ccr_out:std_logic_vector (3 downto 0);
    Rdst:std_logic_vector (0 to 2);
    outjump :std_logic;

end record;



    
  end package;