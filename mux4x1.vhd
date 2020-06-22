Library ieee;
use ieee.std_logic_1164.all;


Entity Mux4x1 is 
  generic (n:integer :=32);
port (
	in1,in2,in3,in4 : in std_logic_vector(n-1 downto 0);
	muxsel: in std_logic_vector(1 downto 0);
	outmux: out std_logic_vector(n-1 downto 0)
);
end entity;

Architecture Mux4 of Mux4x1 is
Begin 

outmux <= in1 when muxsel ="00"
	else in2 when muxsel ="01"
	  else in3 when muxsel ="10"
	    else in4 when muxsel ="11";
	  

end Architecture;

