----------------------------------------------------------------------------------
-- 8-разрядный регистр
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RG_8_bit is
    Port ( Data_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           WR : in  STD_LOGIC;
           Data_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end RG_8_bit;

architecture Behavioral of RG_8_bit is

begin
	process(WR)
	begin
		if (WR' event and WR = '1') then
			Data_OUT <= Data_IN;
		end if;
	end process;

end Behavioral;

