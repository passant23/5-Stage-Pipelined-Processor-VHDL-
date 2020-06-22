Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity partB is 
GENERIC (n : integer := 32);

port(
a : in std_logic_vector (n-1 DOWNTO 0);
b : in std_logic_vector (n-1 DOWNTO 0);
sel: in std_logic_vector (1 DOWNTO 0);
f : out std_logic_vector (n-1 DOWNTO 0);
cout : OUT std_logic);

end entity;

Architecture ModelB of partB is
  
COMPONENT my_nadder IS
GENERIC (n : integer := 32);
PORT(
a, b : IN std_logic_vector (n-1 DOWNTO 0);
cin : IN  std_logic;
s : OUT std_logic_vector (n-1 DOWNTO 0); 
cout : OUT std_logic);
END COMPONENT;


signal nA,nB,outp : std_logic_vector (n-1 DOWNTO 0);
SIGNAL carry : std_logic;

begin
nA<=a;
nB<=b;

adderB: my_nadder port map(nA,nB,'1',outp,carry);

f <= (a and b) WHEN sel(0) = '0' AND sel(1) ='0'
            ELSE std_logic_vector(unsigned(a)+1) WHEN   sel(0) = '0' AND sel(1) ='1'
            ELSE (a or b) WHEN   sel(0) = '1' AND sel(1) ='0' 
            ELSE (not a);
              
 cout <= carry when sel(0)='0' and sel(1)='1'
 else '0';        

end Architecture;