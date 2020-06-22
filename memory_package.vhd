Library ieee;
Use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

package memory_package is
  -- Input--
  type memory_in is record
  --Control Signals-- 
  CallOrNot: std_logic;
  MemWrite: std_logic;
  memRead: std_logic;
  StackAddEA: std_logic;
  SPValue: std_logic;
  SPMUX1: std_logic;
  SPMUX2: std_logic;
  
  --Int Signals--
  IntPush: std_logic_vector (1 downto 0);
  IntWrite: std_logic;
  IntRead: std_logic;
  Counter: std_logic_vector (1 downto 0);
  IntSpMux: std_logic_vector (1 downto 0);
  IntSpValue: std_logic_vector (1 downto 0);
  
  --inputs--
  pc: std_logic_vector (0 to 31);
  read_data1 : std_logic_vector (0 to 31);
  CCR: std_logic_vector (3 downto 0);
  EA: std_logic_vector (9 to 28);

  
  end record memory_in;
  
   type memory_out is record

   DataMemOut: std_logic_vector (0 to 31);
   
   end record memory_out;
     
end package;
   