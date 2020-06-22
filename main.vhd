Library ieee;
Library work;
use ieee.std_logic_1164.all;
use work.buffer_package.all;
use work.fetch_package.all;
--decode package
use work.decode_package.all;
--execute package
use work.execute_package.all;
--memory package
use work.memory_package.all;
use ieee.numeric_std.all;
---FU package
use work.FU_pkg.all;
---HDU package
use work.HD_pckg.all;


entity main is
  port( clock : in std_logic;
	rst,int: in std_logic;
 	inputPort: in std_logic_vector(31 downto 0)

	--interrupt signal
);
end entity main;

Architecture main_arch of main is
  
signal resetFD_DE : std_logic;
  -----FETCH SIGNALS--------
signal fetchin 	: fetch_in;
signal fetchout	: fetch_out;
-----F/D BUFFER SIGNALS----------
signal fd_buffer_in 	: buffer_fetch_decode;
signal fd_buffer_out 	: buffer_fetch_decode;
signal opcode_signal: std_logic_vector(0 to 5);
signal enable_FD: std_logic:='1';

---------------------------------
-------DECODE SIGNALS------------
signal decodein : decode_in;
signal decodeout : decode_out;
signal input_data_wb : std_logic_vector(31 downto 0);


---------------------------------
-----D/E BUFFER SIGNALS----------
signal de_buffer_in : buffer_decode_execute;
signal de_buffer_out : buffer_decode_execute;
signal enable_DE: std_logic:='1';
--------------------------------------
-------EXECUTE SIGNALS-----------
signal executein : execute_in;
signal executeout : execute_out;
-----E/M BUFFER SIGNALS----------
signal em_buffer_in : buffer_execute_memory;
signal em_buffer_out : buffer_execute_memory;
signal enable_EM: std_logic:='1';
---------------------------------
-------MEMORY SIGNALS-------------
signal memoryin: memory_in;
signal memoryout:memory_out;
----------------------------------
-----M/W BUFFER SIGNALS----------
signal mem_buffer_in : buffer_memory_wb;
signal mem_buffer_out : buffer_memory_wb;
signal enable_MW: std_logic:='1';
signal outputPort_en:std_logic:='0';
--------------------------------
--------WB SIGNALS---------------

--------------------------------
-- CONTROL UNIT SIGNALS-----
signal fetchsignals_1:fetch_in;
signal decodesignals_1:decode_in;
signal executesignals_1:execute_in;
signal memorysignals_1:memory_in;
signal wbsignals_1:std_logic_vector(1 downto 0);
signal outputPort_value:std_logic_vector(0 to 31);
signal regtwoop,rsc_sel: std_logic;
----------------------------------------------------
signal imm_5_temp :std_logic_vector(4 downto 0);
----------------------------------------------------
----Forwarding Unit Signals----
signal Frwd_in:fu_in;
signal Frwd_out:fu_out;
-------HDU--------------------
signal hzrd_in:HD_in;
signal hzrd_out: HD_out;
----------------------

component  fetch is
 port(
in_fetch :in fetch_in;
clk,reset:in std_logic;
out_fetch: out fetch_out
 );
 end component;
 
 component buffer_FD is
  port( 
    clk,reset,en:in std_logic;
  buffer_FD_in:in buffer_fetch_decode;
  buffer_FD_out:out buffer_fetch_decode
  
  );
  end component;
  ---DECODE STAGE ENTITY--
  component ID_stage IS 
PORT(clk,rst : IN std_logic;
 -- R: OUT decode_in;
   Rout : OUT decode_out;
     input_fetch : IN buffer_fetch_decode;
     regWrite1, regWrite2 : IN std_logic;
     input_memory : IN buffer_memory_wb;
     input_data_wb : IN std_logic_vector(31 DOWNTO 0)); --from write back stage
     --output_decode : OUT buffer_decode_execute

end component;

---------WB STAGE-----------
  component wb_stage is
  port( 
  wb_d:in buffer_memory_wb;
  
  
  read_data2:out std_logic_vector (31 downto 0)
  --buffer_out:out buffer_memory_wb
  );
  
  end component;
  -----------------------
  ----buffer_DE---------- 
 component buffer_DE is
  port( 
    clk,reset,en:in std_logic;
  buffer_DE_in:in buffer_decode_execute;
  buffer_DE_out:out buffer_decode_execute
  
  );
  end component;  
  ----------------------------
  -----EXECUTE STAGE ENTITY----
 component EX_stage IS
PORT (
  clk,rst: in std_logic;
  EX_stage_in : in execute_in;
  EX_stage_out:out execute_out;
  input_execute_memory : IN buffer_execute_memory;
  input_memory_wb : IN buffer_memory_wb
  
  
  
);
 end component; 
 ---------------------------------
 --OUTPUT PORT
 component reg is 
  GENERIC (n:integer :=32);
  PORT (Clk,Rst,En: IN std_logic;
    d: IN std_logic_vector (n-1 DOWNTO 0);
    q: OUT std_logic_vector(n-1 DOWnTO 0));
  END component;
  ----------------------------
  -----buffer_EM-------------
    
  component buffer_EM is
  port( 
    clk,reset,en:in std_logic;
  buffer_EM_in:in buffer_execute_memory;
  buffer_EM_out:out buffer_execute_memory
  
  );
  end component; 
  
  -----------------------
  -----MEMORY STAGE ENTITY--------
 component memory_stage is
    Port (clk,Rst: in std_logic;	
	  mem_d : in  memory_in;
      mem_q : out memory_out);
  end component;
  ----------------------------
  -----buffer_MW--------------
  component buffer_MW is
  port( 
    clk,reset,en:in std_logic;
  buffer_MW_in:in buffer_memory_wb;
  buffer_MW_out:out buffer_memory_wb
  
  );
  end component;
  -----------------------------
  -----CONTROL UNIT---------
  
component ControlUnit is
port(
--INPUTS-----
opcode: in std_logic_vector(0 to 5); 
stall: in std_logic;
---OUTPUTS-------
--fetching signals--
--------------------
fetchsignals: out fetch_in;
decodesignals:out decode_in;
executesignals:out execute_in;
memorysignals:out memory_in;
wbsignals:out std_logic_vector(1 downto 0);
regop,rsc_sel: out std_logic
--------------------
);
  
 end component; 
  


-------Forwarding Unit--------------

component ForwardingUnit is 
	port (  fu_I : in fu_in; 
		fu_O : out fu_out;
		clk :in std_logic
		);
end component;
  
-----------------------------------------  
component HDU is
  port(HDU_IN : in HD_in; 
	HDU_OUT : out HD_out
);
end component;
  begin 
    
    
-----Forward in signal-------------------
                  
--if executesignals_1.rdst_signal="00"  then
--Frwd_in.RegDst <= fd_buffer_out.instruction_bits(6 to 8); 
--elsif executesignals_1.rdst_signal="01"  then               
--Frwd_in.RegDst <= fd_buffer_out.instruction_bits(9 to 11); 
--elsif executesignals_1.rdst_signal= "10" then
--Frwd_in.RegDst <= fd_buffer_out.instruction_bits(12 to 14);
--end if;
--rsc_sel;
Frwd_in.RegDst <= de_buffer_out.rsc1 when de_buffer_out.RDST_sel="00" else
                  de_buffer_out.rsc2 when de_buffer_out.RDST_sel="01" else 
                  de_buffer_out.rsc3 when de_buffer_out.RDST_sel="10";
                        
Frwd_in.RegDst_ExMem<= em_buffer_out.rdst1;                      
              
Frwd_in.RegSrc <=  de_buffer_out.rsc1 when rsc_sel='0' else
                  de_buffer_out.rsc2 when rsc_sel='1' ;
                                   
Frwd_in.RegSelect <= regtwoop;                      
Frwd_in.RegDst_MemWb <= mem_buffer_out.rdst1;
Frwd_in.RegWrite_ExMem <= em_buffer_out.REG_WRITE;
Frwd_in.RegWrite_MemWB <= mem_buffer_out.REG_WRITE; 



---------------****************--------------------    
------------------FETCH stage---------------------
---------------****************-------------------- 
   
    fd_buffer_in.pc<=fetchout.pc; 
  --  fetchin.inst_size<= 
  fd_buffer_in.input_data_wb <= input_data_wb; 
  
	fd_buffer_in.instruction_bits<=fetchout.instruction_bits; 
	em_buffer_in.instruction_bits<=de_buffer_out.instruction_bits;
	memoryin.EA <= em_buffer_out.instruction_bits(9 to 28);
	memoryin.read_data1 <= em_buffer_out.read_data1;
	mem_buffer_in.read_data1 <= em_buffer_out.read_data1;
	
	
	mem_buffer_in.imm_extended<= x"0000" & em_buffer_out.instruction_bits(9 to 24);
    --fetchin.branch_taken<='0'; 
	em_buffer_in.outjump<=executeout.outjump;
	mem_buffer_in.outjump<=em_buffer_out.outjump;
	 fetchin.branch_taken<=em_buffer_out.outjump;
	 em_buffer_in.read_data1 <= de_buffer_out.read_data1;
	 fetchin.Read_data1<=em_buffer_out.read_data1;
     de_buffer_in.pc <= fd_buffer_out.pc;
     em_buffer_in.pc <= de_buffer_out.pc;
     em_buffer_in.rsc1 <=  de_buffer_out.rsc1;
     em_buffer_in.rsc2 <=  de_buffer_out.rsc2;
     
     --delete this
     --fd_buffer_out<=fd_buffer_in;
----------------****************--------------------    
------------------DECODE stage----------------------
----------------****************--------------------  
de_buffer_in.input_data_wb <= fd_buffer_out.input_data_wb; 

  
de_buffer_in.read_data1<=decodeout.data1;
de_buffer_in.read_data2<=decodeout.data2;
          

de_buffer_in.instruction_bits<=fd_buffer_out.instruction_bits;
de_buffer_in.rsc1<=decodeout.rsc1;
de_buffer_in.rsc2<=decodeout.rsc2;
de_buffer_in.rsc3<=decodeout.rsc3;

--de_buffer_in.FA <= Frwd_out.ForwardA;
--de_buffer_in.FB <= Frwd_out.ForwardB;

------------------ F/D SIGNALS ---------------------
     
------------------ D/E SIGNALS ---------------------
 em_buffer_in.input_data_wb <= de_buffer_out.input_data_wb;  
     
     
----------------****************--------------------    
------------------EXECUTE stage---------------------
----------------****************--------------------
-------------------- D/E SIGNALS -------------------
--CONTROL SIGNALS

--not yet
--ZNC
--branch_bit  
--PoppedorNot
---------------------------------------------------
de_buffer_in.imm_5<=imm_5_temp;


imm_5_temp<=fd_buffer_out.instruction_bits(9)&fd_buffer_out.instruction_bits(10)&fd_buffer_out.instruction_bits(11)&fd_buffer_out.instruction_bits(12)&fd_buffer_out.instruction_bits(13);




--process(clock)
--begin

--if rising_edge(clock)
--then 
executein.branch_bit<=de_buffer_out.branch_bit;
executein.MUX_EXTEND <= de_buffer_out.MUX_EXTEND;
executein.alu_sel <= de_buffer_out.ALUSEL;
executein.rdst_signal <= de_buffer_out.RDST_sel;
executein.CCR_Enable <= de_buffer_out.CCR_Enable;
executein.Rdst_6_8 <= de_buffer_out.rsc1;   
executein.Rdst_9_11 <= de_buffer_out.rsc2;   
executein.Rdst_12_14 <= de_buffer_out.rsc3;    
executein.data1 <= de_buffer_out.read_data1;
executein.data2 <=de_buffer_out.read_data2;
executein.alu_enable<=de_buffer_out.alu_enable;
executein.imm_5 <= de_buffer_out.imm_5;   
executein.imm_16 <= de_buffer_out.instruction_bits(12 to 27);  
--executein.rdst_signal <= de_buffer_out.RDST_sel; 
executein.ALUFU <= em_buffer_out.alu_output;
executein.MemFU <= input_data_wb;
executein.fa <= Frwd_out.ForwardA;
executein.fb <= Frwd_out.ForwardB;

--end if;
--end process; 
--------------------------------------------------
--------------------- STAGES PORT MAP-----------------------
f0:fetch PORT MAP (fetchin,clock,rst,fetchout);
d0 : ID_stage PORT MAP(clock,rst,decodeout,fd_buffer_out,mem_buffer_in.REG_WRITE ,mem_buffer_in.REG_WRITE2 ,mem_buffer_out,input_data_wb);
ex: EX_stage port map (clock,rst,executein,executeout,em_buffer_out,mem_buffer_out);
--ex port map to be updated
memory_stage0:memory_stage port map(clock,rst,memoryin,memoryout);
wb1:wb_stage PORT MAP(mem_buffer_out,input_data_wb);
outputPort:reg PORT MAP(clock,rst,outputPort_en,mem_buffer_out.read_data1,outputPort_value);
   --------------------------------------------------------------------
   
 outputPort_en<= '1' when mem_buffer_out.op="000111"
 else'0';
 
 
 
 
 
-----------------------------------------------------
------------------- E/M SIGNALS----------------
em_buffer_in.alu_output <= executeout.alu_output;
mem_buffer_in.alu_output<=em_buffer_out.alu_output;
em_buffer_in.alu_CCR <= executeout.ccr_out;
em_buffer_in.rdst1 <= executeout.Rdst;
mem_buffer_in.rdst1<=em_buffer_out.rdst1;

fd_buffer_in.input_port <=inputPort;
de_buffer_in.input_port<=fd_buffer_out.input_port;
em_buffer_in.input_port<=de_buffer_out.input_port;
mem_buffer_in.input_port<=em_buffer_out.input_port;
-----------------------------------------------------
----------------****************--------------------    
------------------MEMORY stage---------------------
----------------****************--------------------
-------------------- E/M SIGNALS -------------------
-------------------- M/W SIGNALS -------------------



----------------****************--------------------    
------------------WRITE BACK stage-------------------
----------------****************--------------------


----------------Forwarding Unit----------------------
FORWARD:ForwardingUnit PORT MAP (Frwd_in,Frwd_out,clock); 
HD0: HDU port map (hzrd_in,hzrd_out);
  hzrd_in.Next_Stage_Reg <= de_buffer_out.instruction_bits(6 to 8);
  hzrd_in.Src_Reg<= fd_buffer_out.instruction_bits(6 to 8);
  hzrd_in.Dst_Reg <= fd_buffer_out.instruction_bits(12 to 14);
hzrd_in.Mem_Read <= de_buffer_out.MEM_READ;

hzrd_in.Reset <= rst;

-------------------- M/W SIGNALS -------------------
----------------------------------------------------
-------------CONTROL UNIT -------------------------

    
opcode_signal<=fd_buffer_out.instruction_bits(0 to 5);

cu:ControlUnit PORT MAP(opcode_signal,hzrd_out.Stall_cu,fetchsignals_1,decodesignals_1,executesignals_1,memorysignals_1,wbsignals_1,regtwoop,rsc_sel);

de_buffer_in.op<=opcode_signal;

em_buffer_in.op<=de_buffer_out.op;

mem_buffer_in.op<=em_buffer_out.op;




-------------------------------------------------------------
resetFD_DE <= '1' when rst ='1'
else '1' when em_buffer_out.outjump='1'
else'0';
--------------------MAPPING BUFFER----------------------------
buffer1:buffer_FD PORT MAP (clock,resetFD_DE,hzrd_out.Stall,fd_buffer_in,fd_buffer_out);
buffer2:buffer_DE PORT MAP (clock,resetFD_DE,enable_DE,de_buffer_in,de_buffer_out);
buffer3:buffer_EM  PORT MAP (clock,rst,enable_EM,em_buffer_in,em_buffer_out);
buffer4:buffer_MW PORT MAP (clock,rst,enable_MW,mem_buffer_in,mem_buffer_out);
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--Signals from cu to buffer
de_buffer_in.alu_enable<=executesignals_1.alu_enable;
de_buffer_in.MUX_EXTEND<= executesignals_1.MUX_EXTEND;
de_buffer_in.ALUSEL<= executesignals_1.alu_sel;
de_buffer_in.RDST_sel<=executesignals_1.rdst_signal;
de_buffer_in.CCR_Enable<=executesignals_1.CCR_Enable;
--branching signals
de_buffer_in.branch_bit<=executesignals_1.branch_bit;
--em_buffer_in.branch_bit<=execute_out.outjump;
--fetchin.branch_taken<=executeout.outjump;

de_buffer_in.REG_WRITE<= decodesignals_1.regWrite1;
em_buffer_in.REG_WRITE <= de_buffer_out.REG_WRITE;
mem_buffer_in.REG_WRITE <= em_buffer_out.REG_WRITE ;

de_buffer_in.REG_WRITE2<= decodesignals_1.regWrite2;
em_buffer_in.REG_WRITE2 <= de_buffer_out.REG_WRITE2;
mem_buffer_in.REG_WRITE2 <= em_buffer_out.REG_WRITE2 ;

--wb signals from cu to buffer
de_buffer_in.MEM_TO_REG<=wbsignals_1;
em_buffer_in.MEM_TO_REG<=de_buffer_out.MEM_TO_REG;
mem_buffer_in.MEM_TO_REG<=em_buffer_out.MEM_TO_REG;
 --missing znc signal 
 
de_buffer_in.Sp_Value<=memorysignals_1.SPValue;
de_buffer_in.SP_MUX1<=memorysignals_1.SPMUX1;
de_buffer_in.SP_MUX2<=memorysignals_1.SPMUX2; 
de_buffer_in.callornot<=memorysignals_1.CallOrNot;
de_buffer_in.MEM_READ<=memorysignals_1.memRead;
de_buffer_in.MEM_WRITE<=memorysignals_1.MemWrite;
de_buffer_in.StackAdd_EA<=memorysignals_1.StackAddEA;

em_buffer_in.Sp_Value<=de_buffer_out.Sp_Value;
em_buffer_in.SP_MUX1<=de_buffer_out.SP_MUX1;
em_buffer_in.SP_MUX2<=de_buffer_out.SP_MUX2; 
em_buffer_in.callornot<=de_buffer_out.callornot;
em_buffer_in.MEM_READ<=de_buffer_out.MEM_READ;
em_buffer_in.MEM_WRITE<=de_buffer_out.MEM_WRITE;
em_buffer_in.StackAdd_EA<=de_buffer_out.StackAdd_EA;

memoryin.MemWrite<=em_buffer_out.MEM_WRITE;
mem_buffer_in.memory_output<=memoryout.DataMemOut;




       
    end architecture;