Library ieee;
use ieee.std_logic_1164.all;

package buffer_package is
  -- Fetch/Decode buffer--
  type buffer_fetch_decode is record
    --fetch stage outputs
    instruction_bits : std_logic_vector(0 to 31); 
    pc: std_logic_vector (0 to 31);
  
    input_port:std_logic_vector(31 downto 0);
    rsc1: std_logic_vector (0 to 2);
   
    rsc2: std_logic_vector (0 to 2);
   
    rsc3: std_logic_vector (0 to 2);

    input_data_wb: std_logic_vector (31 downto 0);
  end record buffer_fetch_decode;
------------------------------------------------
--Decode/Execute buffer--
type buffer_decode_execute is record
    --decode stage outputs
    pc: std_logic_vector (0 to 31);
    rsc1: std_logic_vector (0 to 2);
    rsc2: std_logic_vector (0 to 2);
    rsc3: std_logic_vector (0 to 2);
    read_data1 : std_logic_vector (0 to 31);
    read_data2 : std_logic_vector (0 to 31);
    instruction_bits: std_logic_vector (0 to 31);
    op:std_logic_vector(0 to 5);
    imm_5 :std_logic_vector(4 downto 0);
    
    input_port:std_logic_vector(31 downto 0);
    imm_16:std_logic_vector(15 downto 0);
    ----- control unit signals --------
    --decode signals
    REG_WRITE	:std_logic; --msb
    REG_WRITE2: std_logic;
    ---------------------------
    --execute signals
    MUX_EXTEND:std_logic_vector (1 downto 0);
    ALUSEL	:std_logic_vector (3 downto 0);
    RDST_sel	:std_logic_vector (1 downto 0);
    ZNC	:std_logic_vector (1 downto 0);
    CCR_Enable:std_logic;
   	branch_bit	:std_logic;
   	PoppedorNot:std_logic;
   	alu_enable:std_logic;
   	---------------------------
    --memory signals
    Sp_Value 	:std_logic;
    SP_MUX1	:std_logic;
    SP_MUX2	:std_logic;
    callornot	:std_logic;
    MEM_READ	:std_logic;
    MEM_WRITE	:std_logic;
    StackAdd_EA:std_logic;
    -----------------------------
    --WB signals
    MEM_TO_REG: std_logic_vector(1 downto 0);
    --Forward signal
    FA: std_logic_vector(1 downto 0);
    FB: std_logic_vector(1 downto 0);
    input_data_wb: std_logic_vector (31 downto 0);
  end record buffer_decode_execute ;
  ---------------------------------------------------
  type buffer_execute_memory is record
       --decode stage outputs
    pc: std_logic_vector (0 to 31);
    rsc1: std_logic_vector (0 to 2);
    rsc2: std_logic_vector (0 to 2);
    read_data1 : std_logic_vector (0 to 31);
    read_data2 : std_logic_vector (0 to 31);
    instruction_bits: std_logic_vector (0 to 31);
    op:std_logic_vector(0 to 5);
    --execute stage outputs
    alu_output: std_logic_vector(0 to 31);--check
    alu_CCR: std_logic_vector(3 downto 0); --check
    imm_extended:std_logic_vector(31 downto 0);
    rdst1: std_logic_vector (0 to 2);
    rdst2: std_logic_vector (0 to 2);
    outjump: std_logic;
    input_port:std_logic_vector(31 downto 0);
     ----- control unit signals --------
    --memory signals
    Sp_Value 	:std_logic;
    SP_MUX1	:std_logic;
    SP_MUX2	:std_logic;
    callornot	:std_logic;
    MEM_READ	:std_logic;
    MEM_WRITE	:std_logic;
    StackAdd_EA:std_logic;
    -----------------------------
    --WB signals
    MEM_TO_REG: std_logic_vector(1 downto 0);  
    REG_WRITE	:std_logic; --msb
    REG_WRITE2: std_logic;
    input_data_wb: std_logic_vector (31 downto 0);
  end record buffer_execute_memory;
  
  
   type buffer_memory_wb is record
       --execute stage outputs
    alu_output: std_logic_vector(0 to 31);--check
    imm_extended:std_logic_vector(0 to 31);
    input_port:std_logic_vector(31 downto 0);
    rdst1: std_logic_vector (0 to 2);
    rdst2: std_logic_vector (0 to 2);
      --decode stage outputs
    read_data1 : std_logic_vector (0 to 31); 
     -- memory stage outputs 
     memory_output: std_logic_vector(0 to 31);
     op:std_logic_vector(0 to 5);
     imm_16_wb:std_logic_vector(0 to 15);
     outjump:std_logic;
     --inport?
     
     ----- control unit signals --------
    --WB signals
    MEM_TO_REG: std_logic_vector(1 downto 0);
    REG_WRITE	:std_logic; --msb
    REG_WRITE2: std_logic;
    
  end record buffer_memory_wb;
  
  
  
  
  
  
  
  
  
  
  
  
  
end package;