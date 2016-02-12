----------------------------------------------------------------------------------
-- 8-разрядный счетчик
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_8_bit is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end Counter_8_bit;

architecture Behavioral of Counter_8_bit is

signal count_int: STD_LOGIC_VECTOR (7 downto 0):= "00000000" ;

begin

	process (CLK) 
	begin
		if CLK='1' and CLK'event then
			if Reset ='1' then 
				count_int <= (others => '0');
			else count_int <= count_int + 1;
			end if;
		end if;
	end process; 

	Data_OUT <= count_int;

end Behavioral;

