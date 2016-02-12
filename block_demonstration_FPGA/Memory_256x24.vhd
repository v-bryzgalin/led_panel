----------------------------------------------------------------------------------
--Видеопамять 256 х 24
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory_256x24 is
    Port ( CLK : in  STD_LOGIC;
           WR_enable : in  STD_LOGIC;
			  Addr_Bus_WR : in  STD_LOGIC_VECTOR (7 downto 0);
			  Addr_Bus_RD : in  STD_LOGIC_VECTOR (7 downto 0);
           Data_Bus_IN : in  STD_LOGIC_VECTOR (23 downto 0);
			  Data_Bus_OUT : out  STD_LOGIC_VECTOR (23 downto 0));
end Memory_256x24;

architecture Behavioral of Memory_256x24 is

begin

process (CLK)

type ram_type is array (255 downto 0) of std_logic_vector (23 downto 0);
variable mem_data: ram_type;

begin

	if (CLK'event and CLK = '1') then
         if (WR_enable = '1') then
            mem_data(conv_integer(Addr_Bus_WR)) := Data_Bus_IN;
				Data_Bus_OUT <= "ZZZZZZZZZZZZZZZZZZZZZZZZ";
         else
            Data_Bus_OUT <= mem_data(conv_integer(Addr_Bus_RD));
         end if;
   end if;

end process;

end Behavioral;

