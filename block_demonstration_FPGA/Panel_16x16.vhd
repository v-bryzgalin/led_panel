----------------------------------------------------------------------------------
--Модуль отображения панели 16 х 16
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Panel_16x16 is
    Port ( CLK : in  STD_LOGIC;
           WR : in  STD_LOGIC;
           Addr_Bus_Write : in  STD_LOGIC_VECTOR (7 downto 0);
           Data_Bus_IN_Mem : in  STD_LOGIC_VECTOR (23 downto 0);
			  RGB_string: out STD_LOGIC_VECTOR (47 downto 0);
			  Enable_str: out STD_LOGIC_VECTOR (15 downto 0));
end Panel_16x16;

architecture Structural of Panel_16x16 is

component Counter_DC_str is
    Port ( CLK : in  STD_LOGIC;
			  WR_str: out STD_LOGIC;
			  Addr_RD: out  STD_LOGIC_VECTOR (7 downto 0);
	        Enable_str : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component Memory_256x24 is
    Port ( CLK : in  STD_LOGIC;
           WR_enable : in  STD_LOGIC;
			  Addr_Bus_WR : in  STD_LOGIC_VECTOR (7 downto 0);
			  Addr_Bus_RD : in  STD_LOGIC_VECTOR (7 downto 0);
           Data_Bus_IN : in  STD_LOGIC_VECTOR (23 downto 0);
			  Data_Bus_OUT : out  STD_LOGIC_VECTOR (23 downto 0));
end component;

component One_string is
    Port ( CLK : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
			  WR: in STD_LOGIC;
           Addr_Bus : in  STD_LOGIC_VECTOR (3 downto 0);
           Data_Bus : in  STD_LOGIC_VECTOR (23 downto 0);
           RGB_string : out  STD_LOGIC_VECTOR (47 downto 0));
end component;

signal Data_Bus_OUT_Mem: STD_LOGIC_VECTOR (23 downto 0);
signal Case_string: STD_LOGIC_VECTOR (15 downto 0);
signal Addr_Bus_Read: STD_LOGIC_VECTOR (7 downto 0);
signal WR_enable: STD_LOGIC;

begin

Counter_DC: Counter_DC_str
		port map (CLK, WR_enable, Addr_Bus_Read (7 downto 0), Case_string (15 downto 0));

RAM: Memory_256x24
		port map (CLK, WR, Addr_Bus_Write (7 downto 0), Addr_Bus_Read (7 downto 0), Data_Bus_IN_Mem (23 downto 0), Data_Bus_OUT_Mem (23 downto 0));

String_1: One_string
		port map (CLK, Case_string (15), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_2: One_string
		port map (CLK, Case_string (14), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_3: One_string
		port map (CLK, Case_string (13), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_4: One_string
		port map (CLK, Case_string (12), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_5: One_string
		port map (CLK, Case_string (11), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_6: One_string
		port map (CLK, Case_string (10), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_7: One_string
		port map (CLK, Case_string (9), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_8: One_string
		port map (CLK, Case_string (8), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_9: One_string
		port map (CLK, Case_string (7), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_10: One_string
		port map (CLK, Case_string (6), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_11: One_string
		port map (CLK, Case_string (5), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_12: One_string
		port map (CLK, Case_string (4), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_13: One_string
		port map (CLK, Case_string (3), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_14: One_string
		port map (CLK, Case_string (2), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_15: One_string
		port map (CLK, Case_string (1), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));
String_16: One_string
		port map (CLK, Case_string (0), WR_enable, Addr_Bus_Read (3 downto 0), Data_Bus_OUT_Mem (23 downto 0), RGB_string (47 downto 0));

process(CLK)
begin
	Enable_str <= Case_string;
end process;

end Structural;

