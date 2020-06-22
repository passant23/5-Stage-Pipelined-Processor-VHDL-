Library ieee;
use ieee.std_logic_1164.all;

ENTITY dFlipFlop IS
PORT( clk,rst, enable : IN std_logic;
		   input : IN std_logic_vector(31 DOWNTO 0);
		   output : OUT std_logic_vector(31 DOWNTO 0));
END dFlipFlop;

ARCHITECTURE archDFF OF dFlipFlop IS
BEGIN
PROCESS (clk,rst)
BEGIN
IF rst = '1' THEN
		output <= (OTHERS=>'0');
ELSIF falling_edge(clk) THEN
  IF enable='1'THEN
  		output <= input;
	END IF;
		
END IF;
END PROCESS;
END archDFF;
