--------------------------------------------------------------------------------
--Устройство сопряжения с панелью (УСП)
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity USP is
    Port ( CLK : in  STD_LOGIC;
           MOSI : in  STD_LOGIC;
           SCLK : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           AddrBus : in  STD_LOGIC_VECTOR (3 downto 0);
           RGB : out  STD_LOGIC_VECTOR (47 downto 0);
           vkl_str : out  STD_LOGIC_VECTOR (15 downto 0));
end USP;

architecture Structural of USP is

component SPI_connection is
    Port ( CLK : in  STD_LOGIC;
           SPI_MOSI : in  STD_LOGIC;
           SPI_SCLK : in  STD_LOGIC;
           SPI_CS : in  STD_LOGIC;
           WR_panel : out  STD_LOGIC;
           DataBus : out  STD_LOGIC_VECTOR (23 downto 0));
end component;

component Panel_16x16 is
    Port ( CLK : in  STD_LOGIC;
           WR : in  STD_LOGIC;
           Addr_Bus_Write : in  STD_LOGIC_VECTOR (7 downto 0);
           Data_Bus_IN_Mem : in  STD_LOGIC_VECTOR (23 downto 0);
			  RGB_string: out STD_LOGIC_VECTOR (47 downto 0);
			  Enable_str: out STD_LOGIC_VECTOR (15 downto 0));
end component;

component Counter_decr is
    Port ( WR : in  STD_LOGIC;
           Addr_Low : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal WR: STD_LOGIC;
signal Data: STD_LOGIC_VECTOR (23 downto 0);
signal Adres: STD_LOGIC_VECTOR (7 downto 0);

begin

SPI: SPI_connection
		port map (CLK, MOSI, SCLK, CS, WR, Data (23 downto 0));

Panel: Panel_16x16
		port map (CLK, WR, Adres (7 downto 0), Data (23 downto 0), RGB (47 downto 0), vkl_str (15 downto 0));

Counter: Counter_decr
		port map (WR, Adres (3 downto 0));

process(AddrBus)
begin
	Adres (7 downto 4) <= AddrBus (3 downto 0);
end process;

end Structural;

