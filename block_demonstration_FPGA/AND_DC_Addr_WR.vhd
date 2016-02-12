----------------------------------------------------------------------------------
--Блок формирования сигнала записи в МОП
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AND_DC_Addr_WR is
    Port ( DC_Addr : in  STD_LOGIC;
           WR : in  STD_LOGIC;
           WR_pix : out  STD_LOGIC);
end AND_DC_Addr_WR;

architecture Behavioral of AND_DC_Addr_WR is

begin
	
	WR_pix <= DC_Addr AND WR;

end Behavioral;

