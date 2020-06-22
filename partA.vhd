LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY partA IS
GENERIC (n : integer := 32);
PORT (
a, b : IN std_logic_vector (n-1 DOWNTO 0);
--cin : IN  std_logic;
sel: in std_logic_vector (1 DOWNTO 0);
s : OUT std_logic_vector (n-1 DOWNTO 0); 
cout : OUT std_logic);
END partA;

ARCHITECTURE mypartA OF partA IS

COMPONENT my_nadder IS
GENERIC (n : integer := 32);
PORT(
a, b : IN std_logic_vector (n-1 DOWNTO 0);
cin : IN  std_logic;
s : OUT std_logic_vector (n-1 DOWNTO 0); 
cout : OUT std_logic);
END COMPONENT;

SIGNAL Stemp,Btemp,Atemp : std_logic_vector (n-1 DOWNTO 0);
SIGNAL cininternal : std_logic;

BEGIN

Btemp<= (others=>'0') when sel(0)='0' and sel(1)='0'
else b when sel(0)='1' and sel(1)='0'
else not b when sel(0)='0' and sel(1)='1'
else (others=>'1'); 
  
cininternal<='1' when sel(0)='0' and sel(1)='0'
else '0' when sel(0)='1' and sel(1)='0'
else '1' when sel(0)='0' and sel(1)='1'
else '0';
 
 Atemp <= (others=>'0') when sel(0) ='0' and sel(1)='0'
 else a;
  

theadder: my_nadder port map( Atemp,Btemp,cininternal,Stemp,cout);

s<= (others=>'0') when sel(0) ='0' and sel(1)='0'
else Stemp;
  
 

end mypartA;