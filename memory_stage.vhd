Library ieee;
Library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.memory_package.all;

Entity memory_stage is
    Port (clk,Rst: in std_logic;	
	  mem_d : in  memory_in;
      mem_q : out memory_out);
End Entity memory_stage;

Architecture mem_stg of memory_stage is

Component memory is 
Generic (n : integer := 11; m : integer := 32);
	port (	clk: in std_logic;
		we: in std_logic; --writeEnable
		address: in std_logic_vector(n-1 downto 0);
		dataIn: in std_logic_vector(m-1 downto 0);
		dataOut: out std_logic_vector(m-1 downto 0)
		);
End Component memory;

component reg is 
GENERIC (n:integer :=32);
  PORT (Clk,Rst,En: IN std_logic;
    d: IN std_logic_vector (n-1 DOWNTO 0);
    q: OUT std_logic_vector(n-1 DOWnTO 0));
END component reg;

component Int_priority is
    Port (Input,Int_signal: in std_logic;	
	  counter : in  std_logic_vector (1 downto 0);
      Output : out std_logic);
End component Int_priority;

signal current_sp:std_logic_vector(31 downto 0):=(others=>'0');
signal out_sp: std_logic_vector(31 downto 0);
signal we: std_logic;
signal OutMuxCallOrnot: std_logic_vector (31 downto 0);
signal PcAdded: std_logic_vector (0 to 31);
signal OutMuxIntPush: std_logic_vector (31 downto 0);
signal ExtendedCCR: std_logic_vector (31 downto 0);
signal ExtEA: std_logic_vector (0 to 31);
signal SpMem: std_logic_vector (0 to 31);
signal OutMuxStackAddEa: std_logic_vector (31 downto 0);
signal OutMuxIntSp: std_logic_vector (31 downto 0); 
signal OutMuxReset: std_logic_vector (31 downto 0);
signal FinalAddr: std_logic_vector (10 downto 0);
signal EffAdd: std_logic_vector (10 downto 0);


Begin

WriteEn:Int_priority PORT MAP(mem_d.MemWrite,mem_d.IntWrite,mem_d.Counter,we);
SP:reg PORT MAP(clk,Rst,'1',current_sp,out_sp);

PcAdded<= std_logic_vector((unsigned(mem_d.pc))+1);

OutMuxCallOrnot<= PcAdded when (mem_d.CallOrNot ='0') else
                  mem_d.read_data1;

ExtendedCCR<= x"0000000" & mem_d.CCR;				  

OutMuxIntPush<= OutMuxCallOrnot when (mem_d.IntPush="00") else --Data that will be written in data mem
                mem_d.pc when (mem_d.IntPush="01") else
				ExtendedCCR when (mem_d.IntPush="10");
				
ExtEA<= "000000000000" & mem_d.EA;
OutMuxStackAddEa<= ExtEA when (mem_d.StackAddEA ='0') else 
                   SpMem;
				   
OutMuxIntSp<= current_sp when (mem_d.IntSpMux ="00") else
              std_logic_vector((unsigned(current_sp))-2) when ( mem_d.IntSpMux = "01") else
			  x"00000002" when (mem_d.IntSpMux="10") else
			  OutMuxStackAddEa;
			  
OutMuxReset<= OutMuxIntSp when(Rst='0') else
			  x"00000000";
			  
FinalAddr<= OutMuxReset(10 downto 0);

EffAdd <= mem_d.EA(18 to 28);    --last 11 bits !!!

Data_mem:memory PORT MAP(clk,mem_d.MemWrite,EffAdd,mem_d.read_data1,mem_q.DataMemOut);
			  
end mem_stg;