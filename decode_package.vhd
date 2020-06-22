Library ieee;
use ieee.std_logic_1164.all;
use work.buffer_package.all;

package decode_package is  
  
  type decode_in is record
    
Rsrc1:std_logic_vector (0 to 2);
Rsrc2:std_logic_vector (0 to 2);
regWrite1:std_logic;
regWrite2:std_logic;
Rdst1:std_logic_vector (0 to 2);
Rdst2:std_logic_vector (0 to 2);
dataDst1 :std_logic_vector (31 downto 0); -- wb data
dataDst2 :std_logic_vector (31 downto 0);



end record;

  type decode_out is record
    
data1 : std_logic_vector (31 downto 0);
data2 : std_logic_vector (31 downto 0);
rsc1 : std_logic_vector (0 to 2);
rsc2: std_logic_vector (0 to 2);
rsc3: std_logic_vector (0 to 2);


end record;



    
  end package;


