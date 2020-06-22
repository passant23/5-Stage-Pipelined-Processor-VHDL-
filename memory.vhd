
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity Memory is 
Generic (n : integer := 11; m : integer := 32);
	port (	clk: in std_logic;
		we: in std_logic; --writeEnable
		address: in std_logic_vector(n-1 downto 0);
		dataIn: in std_logic_vector(m-1 downto 0);
		dataOut: out std_logic_vector(m-1 downto 0)
		);
end entity Memory;

architecture mem of Memory is
type ram_type is array (0 to  (2**n)-1) of std_logic_vector(15 downto 0);
signal ram: ram_type;
begin
    -- asynchronous read
dataOut<= ram(to_integer(unsigned(address)))&ram(to_integer(unsigned(address)+1)) ;
	process(clk, we) is --synchronous
	begin
	if we = '1' and rising_edge(clk) then
		ram(to_integer(unsigned(address)))<= dataIn(31 downto 16);
		ram(to_integer(unsigned(address)+1))<= dataIn(15 downto 0);
	end if;
				
		end process;
	
end architecture mem;