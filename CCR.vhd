Library ieee;
use ieee.std_logic_1164.all;

 ENTITY CCR IS
 generic (n:integer :=4);
  port(
clk, rst, we : in std_logic;
CCRd: in std_logic_vector(n-1 downto 0);
CCRq: out std_logic_vector(n-1 downto 0)
);

END CCR;


ARCHITECTURE myCCR OF CCR IS
BEGIN
process (clk, rst)
begin
	if (rst = '1') then
		CCRq <= "0000";
	elsif falling_edge(clk) and we = '1' then
		CCRq <= CCRd;
	end if;
end process;
end architecture;
	
	