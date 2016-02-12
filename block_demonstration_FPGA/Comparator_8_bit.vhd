----------------------------------------------------------------------------------
-- 8-разрядный компаратор
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Comparator_8_bit is
    Port ( CLK : in  STD_LOGIC;
           Data1 : in  STD_LOGIC_VECTOR (7 downto 0);
           Data2 : in  STD_LOGIC_VECTOR (7 downto 0);
           Bigger_inv : out  STD_LOGIC);
end Comparator_8_bit;

architecture Behavioral of Comparator_8_bit is

begin

process(CLK)
begin
   if (CLK'event and CLK ='1') then   
      if ( Data1 > Data2 ) then 
         Bigger_inv <= '0'; -- invertor after comparator
      else 
         Bigger_inv <= '1';
      end if;
   end if; 
end process; 

end Behavioral;

