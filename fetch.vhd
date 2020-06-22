Library ieee;
Library work;
use ieee.std_logic_1164.all;
use work.buffer_package.all;
use work.fetch_package.all;
use ieee.numeric_std.all;
entity fetch is
 port(
in_fetch :in fetch_in;
clk,reset:in std_logic;
out_fetch: out fetch_out
 );
  
end fetch;


architecture fetch_arch of fetch is
  
  component reg is 
  GENERIC (n:integer :=32);
  PORT (Clk,Rst,En: IN std_logic;
    d: IN std_logic_vector (n-1 DOWNTO 0);
    q: OUT std_logic_vector(n-1 DOWnTO 0));
  END component;
  

  
 component memory is
  Generic (n : integer := 11; m : integer := 32);
	port (	clk: in std_logic;
		we: in std_logic; --writeEnable
		address: in std_logic_vector(n-1 downto 0);
		dataIn: in std_logic_vector(m-1 downto 0);
		dataOut: out std_logic_vector(m-1 downto 0)
		); 
  
end component;

signal inst_mem_out:std_logic_vector(0 to 31);
signal address_inst:std_logic_vector(10 downto 0);
--
signal current_pc:std_logic_vector(31 downto 0):=(others=>'0');
signal out_pc: std_logic_vector(31 downto 0);
 signal reg_enable:std_logic:='1';
 signal size_bit:std_logic;
signal op:std_logic_vector(0 to 4);
signal fetchinputs:fetch_in;
 --signal ReturnorNot:std_logic;
signal plus1_or_plus2:std_logic_vector(31 downto 0):=(others=>'0');
signal new_pc: std_logic_vector(31 downto 0);
--
--
begin
--nadder:my_nadder PORT MAP(current_pc,plus1_or_plus2,'0',out_pc);
pc:reg PORT MAP(clk,reset,reg_enable,current_pc,out_pc);
--f_control: fetch_control PORT MAP (size_bit,op,plus1_or_plus2,ReturnorNot);
inst_mem:memory PORT MAP(clk,'0',address_inst,(others=>'0'),inst_mem_out);

out_fetch.instruction_bits<= inst_mem_out;
out_fetch.pc<=current_pc;



op<=inst_mem_out(1 to 5);
size_bit<=inst_mem_out(0);

address_inst <=current_pc(10 downto 0);
  process(clk,reset)

begin
 if rising_edge(clk) and reset='0'
 then
      op<=inst_mem_out(1 to 5);
size_bit<=inst_mem_out(0);

    if reg_enable='1' then 
 if  in_fetch.branch_taken='1' then
  
  current_pc<=in_fetch.Read_data1;
  elsif size_bit='0' then 
  current_pc<=std_logic_vector(unsigned(current_pc)+1);
  elsif size_bit='1' then 
  current_pc<=std_logic_vector(unsigned(current_pc)+2);
elsif size_bit = 'U' then
 current_pc<=std_logic_vector(unsigned(current_pc)+1);

  
  end if;
  end if;

  end if;


  
  --end;



end process;



end architecture;