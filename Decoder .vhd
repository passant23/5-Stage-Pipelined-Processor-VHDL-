Library ieee;
use ieee.std_logic_1164.all;

ENTITY Decoder IS
  PORT( sel : IN std_logic_vector (0 TO 2);
		   rst,enable : IN std_logic;
		   output : OUT std_logic_vector(7 DOWNTO 0));
END Decoder;

ARCHITECTURE archDecoder OF Decoder IS
  
  BEGIN
    output <= "00000001" WHEN enable = '1'  AND sel = "000"
         ELSE "00000010" WHEN enable = '1'  AND sel = "001"
         ElSE "00000100" WHEN enable = '1'  AND sel = "010"
         ELSE "00001000" WHEN enable = '1'  AND sel = "011"
         ELSE "00010000" WHEN enable = '1'  AND sel = "100"
         ElSE "00100000" WHEN enable = '1'  AND sel = "101"
         ELSE "01000000" WHEN enable = '1'  AND sel = "110"
         ELSE "10000000" WHEN enable = '1'  AND sel = "111"
         ELSE "00000000";
    
END archDecoder;


