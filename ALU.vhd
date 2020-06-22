Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;


entity ALU is 
GENERIC (n : integer := 32);
port(
a : in std_logic_vector (n-1 DOWNTO 0);
b : in std_logic_vector (n-1 DOWNTO 0);
CCRin : in std_logic_vector (3 DOWNTO 0);
sel: in std_logic_vector (3 DOWNTO 0);
--carryin : in std_logic;
f : out std_logic_vector (n-1 DOWNTO 0);
--cout : out std_logic;
CCRout : out std_logic_vector (3 DOWNTO 0)
);

end ALU;

ARCHITECTURE struct OF ALU IS
  COMPONENT partA IS
GENERIC (n : integer := 32);
PORT (
a, b : IN std_logic_vector (n-1 DOWNTO 0);
--cin: IN  std_logic;
sel: in std_logic_vector (1 DOWNTO 0);
s : OUT std_logic_vector (n-1 DOWNTO 0); 
cout : OUT std_logic);
END COMPONENT;


  COMPONENT partB is 
GENERIC (n : integer := 32);
port(
a : in std_logic_vector (n-1 DOWNTO 0);
b : in std_logic_vector (n-1 DOWNTO 0);
sel: in std_logic_vector (1 DOWNTO 0);
f : out std_logic_vector (n-1 DOWNTO 0);
cout : OUT std_logic);
    END COMPONENT;
    
    SIGNAL OUTA,OUTB,OUTshiftR,OUTshiftL,zerotest,negtest:std_logic_vector (n-1 DOWNTO 0);
    SIGNAL selAB :std_logic_vector (1 DOWNTO 0);
    SIGNAL couta,coutb,COUTTEMP,CCR2R,CCR2L:std_logic;
    
     BEGIN
       
       selAB <= sel(1)&sel(0);
      
       
       outputA : partA generic map(32) PORT MAP(a,b,selAB,OUTA,couta);
       outputB : partB generic map(32) PORT MAP(a,b,selAB,OUTB,coutb);
       
      
     
Process(a,b,sel)
    variable shifttempR : std_logic_vector (31 downto 0) := x"00000000";
    variable shifttempL : std_logic_vector (31 downto 0) := x"00000000";
    begin
     if sel = "1000"
 then OUTshiftR <= shifttempR(to_integer(unsigned(b))-1 downto 0) & a(31 downto to_integer(unsigned(b))); -- SHR
 elsif sel = "1100"
 then OUTshiftL <= a((31 - to_integer(unsigned(b))) downto 0 ) & shifttempL(to_integer(unsigned(b))-1 downto 0);--SHL 
      
      
       End If;
        end process;
        
        
        
        
    Process(a,b,sel)
    BEGIN    
         if sel = "1000"
 then CCR2R <= a( to_integer(unsigned(b))); -- SHR
 elsif sel = "1100"
 then CCR2L <= a(31-to_integer(unsigned(b)));--SHL
   
     End If;
        end process;
             
             f <= OUTA WHEN sel(2) = '0' AND sel(3) ='0'
            ELSE OUTB WHEN   sel(2)= '1' AND sel(3) ='0'
            ELSE b when sel = "1111"   --swap
           -- else std_logic_vector(unsigned(a)+1) when sel = "0110"
           else OUTshiftR when sel="1000" --shift Right
            else OUTshiftL when sel= "1100" --shift left
            else (others=>'0');
              
              zerotest <=OUTA WHEN sel(2) = '0' AND sel(3) ='0'
            ELSE OUTB WHEN   sel(2)= '1' AND sel(3) ='0';
            
           
              
           
              --CARRY FLAG : CCRout(2)
               CCRout(2) <=  couta when sel="0001"  --partA  
             else    couta when sel="0010"  --parta
              else    couta when sel="0011"  --parta 
               else coutb when sel="0101" --partb 
               else coutb when sel="0110" --partb  
             else '0' when CCRin(2) ='1' and sel = "1011" --JC
            ELSE '0' WHEN sel ="1110" --CLRC
            ELSE '1' WHEN sel = "1101" --SETC
           ELSE CCR2R when sel = "1000"  --SHR
           ELSE CCR2L when sel= "1100"  --SHL
            else CCRin(2);
              
              --NEGATIVE FLAG : CCRout(1)
              CCRout(1) <= '0' when CCRin(1)='1' and sel= "1010"  --JN
            else zerotest(31) when sel="0111"   --NOT
            else zerotest(31) when sel="0110"   --INC
               else zerotest(31) when sel="0011"    --DEC
                  else zerotest(31) when sel="0101"    --OR
                     else zerotest(31) when sel="0001" --ADD/IADD
                        else zerotest(31) when sel="0010" --SUB
                           else zerotest(31) when sel="0100"
                         else CCRin(1) ;  --AND
              
              
              --ZERO FLAG : CCRout(0)
              CCRout(0) <= '0' when CCRin(0)='1' AND sel="1001" --JZ
            else '1' when zerotest = x"00000000" AND sel="0111"   --NOT
            else '0' when sel="0111"  --NOT;
             else '1'  when zerotest = x"00000000" AND  sel="0110"   --INC
             else '0'  when sel="0110"  --INC;
                else '1'  when zerotest = x"00000000" AND  sel="0011"    --DEC
                else'0'  when  sel="0011"  --DEC;
                 else'1'  when zerotest = x"00000000" AND  sel="0101"    --OR
                 else'0' when   sel="0101"    --OR;
                  else  '1'  when zerotest = x"00000000" AND  sel="0001" --ADD/IADD
                   else'0'  when  sel="0001"   --ADD/IADD;
                      else '1'  when zerotest = x"00000000" AND  sel="0010" --SUB
                      else '0' when sel="0010"  --SUB;
                       else '1'  when zerotest = x"00000000" AND  sel="0100"  --AND
                       else'0' when  sel="0100"  --AND;
                       else CCRin(0);
                   
                   
                --NEGLECTED BIT
             CCRout(3) <='0';     
                  
             
         END struct;