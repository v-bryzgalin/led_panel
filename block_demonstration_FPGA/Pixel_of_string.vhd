----------------------------------------------------------------------------------
--Модуль отображения пикселя (МОП)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Pixel_of_string is
    Port ( CLK : in  STD_LOGIC;
           DataBus : in  STD_LOGIC_VECTOR (23 downto 0);
           WR : in  STD_LOGIC;
			  R: out STD_LOGIC;
			  G: out STD_LOGIC;
			  B: out STD_LOGIC);
end Pixel_of_string;

architecture Structural of Pixel_of_string is

	component RG_8_bit
	Port ( Data_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           WR : in  STD_LOGIC;
           Data_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component Counter_8_bit is
   Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_OUT : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component Comparator_8_bit is
   Port ( CLK : in  STD_LOGIC;
           Data1 : in  STD_LOGIC_VECTOR (7 downto 0);
           Data2 : in  STD_LOGIC_VECTOR (7 downto 0);
           Bigger_inv : out  STD_LOGIC);
	end component;
	
	signal count_comp: STD_LOGIC_VECTOR (7 downto 0);
	signal RG1_comp1: STD_LOGIC_VECTOR (7 downto 0);
	signal RG2_comp2: STD_LOGIC_VECTOR (7 downto 0);
	signal RG3_comp3: STD_LOGIC_VECTOR (7 downto 0);
	
begin

	RG1: RG_8_bit
		port map (DataBus (23 downto 16), WR, RG1_comp1 (7 downto 0));
	RG2: RG_8_bit
		port map (DataBus (15 downto 8), WR, RG2_comp2 (7 downto 0));
	RG3: RG_8_bit
		port map (DataBus (7 downto 0), WR, RG3_comp3 (7 downto 0));

	Counter: Counter_8_bit
		port map (CLK, WR, count_comp (7 downto 0));
		
	Comparator1: Comparator_8_bit
		port map (CLK, count_comp (7 downto 0), RG1_comp1 (7 downto 0), R);
	Comparator2: Comparator_8_bit
		port map (CLK, count_comp (7 downto 0), RG2_comp2 (7 downto 0), G);
	Comparator3: Comparator_8_bit
		port map (CLK, count_comp (7 downto 0), RG3_comp3 (7 downto 0), B);

end Structural;

