----------------------------------------------------------------------------------
--Интерфейсный блок
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SPI_connection is
    Port ( CLK : in  STD_LOGIC;
           SPI_MOSI : in  STD_LOGIC;
           SPI_SCLK : in  STD_LOGIC;
           SPI_CS : in  STD_LOGIC;
           WR_panel : out  STD_LOGIC;
           DataBus : out  STD_LOGIC_VECTOR (23 downto 0));
end SPI_connection;

architecture Behavioral of SPI_connection is

begin

process (SPI_SCLK, SPI_CS)

variable counter: integer := 23;

begin
	if SPI_SCLK = '1' and SPI_SCLK' event then
		if SPI_CS = '0' then DataBus(counter) <= SPI_MOSI;
									counter := counter - 1;
		end if;
		
		if counter = 0 then 	DataBus(counter) <= SPI_MOSI;
									WR_panel <= '1';
									counter := 23;
		else WR_panel <= '0';
		end if;
	end if;	
	
end process;

end Behavioral;

