Library ieee;
Library work;
use ieee.std_logic_1164.all;
use work.buffer_package.all;
use work.execute_package.all;


ENTITY EX_stage IS
PORT (
  clk,rst: in std_logic;
  EX_stage_in : in execute_in;
  EX_stage_out:out execute_out;
  input_execute_memory : IN buffer_execute_memory;
  input_memory_wb : IN buffer_memory_wb
  
  
);
END EX_stage;


ARCHITECTURE my_EX_stage OF EX_stage IS
  
  
  
COMPONENT ALU is 
GENERIC (n : integer := 32);
port(
a : in std_logic_vector (n-1 DOWNTO 0);
b : in std_logic_vector (n-1 DOWNTO 0);
CCRin : in std_logic_vector (3 DOWNTO 0);
sel: in std_logic_vector (3 DOWNTO 0);
f : out std_logic_vector (n-1 DOWNTO 0);
CCRout : out std_logic_vector (3 DOWNTO 0)
);
END COMPONENT;


COMPONENT CCR IS
   generic (n:integer :=4);
   port(
clk, rst, we : in std_logic;
CCRd: in std_logic_vector(n-1 downto 0);
CCRq: out std_logic_vector(n-1 downto 0)
);
END COMPONENT;


COMPONENT Mux4x1 is 
generic (n:integer :=32);
port (
	in1,in2,in3,in4 : in std_logic_vector(n-1 downto 0);
	muxsel: in std_logic_vector(1 downto 0);
	outmux: out std_logic_vector(n-1 downto 0)
);
END COMPONENT;

SIGNAL extendedimm5,extendedimm16,OUT_MUX ,out_FUA,out_FUB,out_mux_wb: std_logic_vector(31 downto 0);
SIGNAL CCRinsig,CCRoutsig : std_logic_vector (3 downto 0);
SIGNAL Rdst_alu : std_logic_vector (0 to 2);

signal exout:std_logic_vector(31 downto 0);
begin

extendedimm5 <= "000000000000000000000000000" & EX_stage_in.imm_5;
extendedimm16 <= x"0000" & EX_stage_in.imm_16;


CCR_EX : CCR generic map(4) PORT MAP(clk,rst,EX_stage_in.CCR_Enable,CCRoutsig,CCRinsig);
MUX4_b_ALU : Mux4x1 generic map(32) PORT MAP(EX_stage_in.data2,extendedimm16,extendedimm5,(others=>'0'),EX_stage_in.MUX_EXTEND,OUT_MUX);
ALU_EX : ALU generic map(32) PORT MAP(out_FUA,out_FUB,CCRinsig,EX_stage_in.alu_sel,exout,CCRoutsig);
--ALU_EX : ALU generic map(32) PORT MAP(EX_stage_in.data1,OUT_MUX,CCRinsig,EX_stage_in.alu_sel,exout,CCRoutsig);
MUX4_Rdst :  Mux4x1 generic map(3) PORT MAP(EX_stage_in.Rdst_6_8,EX_stage_in.Rdst_9_11,EX_stage_in.Rdst_12_14,(others=>'0'),EX_stage_in.rdst_signal,Rdst_alu);
MUX_FU1: Mux4x1 generic map(32) PORT MAP(EX_stage_in.data1,out_mux_wb,EX_stage_in.ALUFU,(others=>'0'),EX_stage_in.fa,out_FUA);
MUX_FU2: Mux4x1 generic map(32) PORT MAP(OUT_MUX,out_mux_wb,EX_stage_in.ALUFU,(others=>'0'),EX_stage_in.fb,out_FUB);
mux_wb:  Mux4x1 generic map(32) PORT MAP(input_memory_wb.alu_output,input_memory_wb.imm_extended,input_memory_wb.input_port,input_memory_wb.memory_output,input_memory_wb.MEM_TO_REG,out_mux_wb);
   
    process(clk)
    begin
      if rising_edge(clk) 
	  then 
	  if EX_stage_in.alu_enable='1' 
	  then
     EX_stage_out.alu_output  <= exout;
             
 if  EX_stage_in.alu_sel = "1001" 
   then EX_stage_out.outjump <= CCRinsig(0);
	elsif   EX_stage_in.alu_sel = "1010" 
    then EX_stage_out.outjump <= CCRinsig(1);
elsif   EX_stage_in.alu_sel = "1011" 
 then EX_stage_out.outjump <= CCRinsig(2);
	  elsif   EX_stage_in.alu_sel="0000" and EX_stage_in.branch_bit='1' then EX_stage_out.outjump <= '1';
	 elsif   EX_stage_in.branch_bit='0' then EX_stage_out.outjump <= '0';
	
        end if;
		
 elsif falling_edge(clk) then
 EX_stage_out.ccr_out<= CCRoutsig;
    
	 end if;
	 end if;
    end process;
           
  
EX_stage_out.Rdst <= Rdst_alu;
end my_EX_stage;