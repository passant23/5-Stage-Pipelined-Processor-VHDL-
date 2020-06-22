Library ieee;
Library work;
use ieee.std_logic_1164.all;

Entity Int_priority is
    Port (Input,Int_signal: in std_logic;	
	  counter : in  std_logic_vector (1 downto 0);
      Output : out std_logic);
End Entity Int_priority;

Architecture Priority of Int_priority is
Begin
Output<= '1' when counter="00" and Int_signal='1' else
         '1' when counter="01" and Int_signal='1' else
		 '0' when counter="10" and Int_signal='0' else
		 Input;
		 
end Architecture;