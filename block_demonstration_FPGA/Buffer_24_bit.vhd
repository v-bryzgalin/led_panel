----------------------------------------------------------------------------------
--Блок включения строки
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Buffer_24_bit is
    Port ( CLK : in  STD_LOGIC;
			  Enable : in  STD_LOGIC;
           Data_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           Data_OUT : out  STD_LOGIC_VECTOR (23 downto 0));
end Buffer_24_bit;

architecture Behavioral of Buffer_24_bit is

begin

process (CLK, Enable)
begin
	if (CLK'event and CLK = '1') then
		if (Enable='0') then
			Data_OUT <= Data_IN;
		else
			Data_OUT <= "ZZZZZZZZZZZZZZZZZZZZZZZZ";
		end if;
	end if;
end process;

end Behavioral;

