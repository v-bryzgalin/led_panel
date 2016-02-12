----------------------------------------------------------------------------------
--Модуль отображения строки (МОС)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity One_string is
    Port ( CLK : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
			  WR: in STD_LOGIC;
           Addr_Bus : in  STD_LOGIC_VECTOR (3 downto 0);
           Data_Bus : in  STD_LOGIC_VECTOR (23 downto 0);
           RGB_string : out  STD_LOGIC_VECTOR (47 downto 0));
end One_string;

architecture Structural of One_string is

component Pixel_of_string is
    Port ( CLK : in  STD_LOGIC;
           DataBus : in  STD_LOGIC_VECTOR (23 downto 0);
           WR : in  STD_LOGIC;
			  R: out STD_LOGIC;
			  G: out STD_LOGIC;
			  B: out STD_LOGIC);
end component;

component Buffer_24_bit is
    Port ( CLK : in  STD_LOGIC;
			  Enable : in  STD_LOGIC;
           Data_IN : in  STD_LOGIC_VECTOR (23 downto 0);
           Data_OUT : out  STD_LOGIC_VECTOR (23 downto 0));
end component;

component DC_Addr is
    Port ( 	CLK: in STD_LOGIC;
				Addr_Bus : in  STD_LOGIC_VECTOR (3 downto 0);
				DC_Addr_Bus : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component AND_DC_Addr_WR is
    Port ( DC_Addr : in  STD_LOGIC;
           WR : in  STD_LOGIC;
           WR_pix : out  STD_LOGIC);
end component;

signal DC_signal: STD_LOGIC_VECTOR (15 downto 0);
signal Buffer_signal: STD_LOGIC_VECTOR (23 downto 0);
signal WR_to_pix: STD_LOGIC_VECTOR (15 downto 0);
signal RGB_buffer: STD_LOGIC_VECTOR (47 downto 0);

begin

DC_Addr_Stb: DC_Addr
		port map (CLK, Addr_Bus (3 downto 0), DC_signal (15 downto 0));

Buffer_Str: Buffer_24_bit
		port map (CLK, Enable, Data_Bus (23 downto 0), Buffer_signal (23 downto 0));
Buffer_RGB1: Buffer_24_bit
		port map (CLK, Enable, RGB_buffer (47 downto 24), RGB_string (47 downto 24));
Buffer_RGB2: Buffer_24_bit
		port map (CLK, Enable, RGB_buffer (23 downto 0), RGB_string (23 downto 0));

WR_to_pix_15: AND_DC_Addr_WR
		port map (DC_signal (15), WR, WR_to_pix (15));
WR_to_pix_14: AND_DC_Addr_WR
		port map (DC_signal (14), WR, WR_to_pix (14));
WR_to_pix_13: AND_DC_Addr_WR
		port map (DC_signal (13), WR, WR_to_pix (13));
WR_to_pix_12: AND_DC_Addr_WR
		port map (DC_signal (12), WR, WR_to_pix (12));
WR_to_pix_11: AND_DC_Addr_WR
		port map (DC_signal (11), WR, WR_to_pix (11));
WR_to_pix_10: AND_DC_Addr_WR
		port map (DC_signal (10), WR, WR_to_pix (10));
WR_to_pix_9: AND_DC_Addr_WR
		port map (DC_signal (9), WR, WR_to_pix (9));
WR_to_pix_8: AND_DC_Addr_WR
		port map (DC_signal (8), WR, WR_to_pix (8));
WR_to_pix_7: AND_DC_Addr_WR
		port map (DC_signal (7), WR, WR_to_pix (7));
WR_to_pix_6: AND_DC_Addr_WR
		port map (DC_signal (6), WR, WR_to_pix (6));
WR_to_pix_5: AND_DC_Addr_WR
		port map (DC_signal (5), WR, WR_to_pix (5));
WR_to_pix_4: AND_DC_Addr_WR
		port map (DC_signal (4), WR, WR_to_pix (4));
WR_to_pix_3: AND_DC_Addr_WR
		port map (DC_signal (3), WR, WR_to_pix (3));
WR_to_pix_2: AND_DC_Addr_WR
		port map (DC_signal (2), WR, WR_to_pix (2));
WR_to_pix_1: AND_DC_Addr_WR
		port map (DC_signal (1), WR, WR_to_pix (1));
WR_to_pix_0: AND_DC_Addr_WR
		port map (DC_signal (0), WR, WR_to_pix (0));
				
Pixel_1: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (15), RGB_buffer (47), RGB_buffer (46), RGB_buffer (45));
Pixel_2: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (14), RGB_buffer (44), RGB_buffer (43), RGB_buffer (42));
Pixel_3: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (13), RGB_buffer (41), RGB_buffer (40), RGB_buffer (39));
Pixel_4: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (12), RGB_buffer (38), RGB_buffer (37), RGB_buffer (36));
Pixel_5: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (11), RGB_buffer (35), RGB_buffer (34), RGB_buffer (33));
Pixel_6: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (10), RGB_buffer (32), RGB_buffer (31), RGB_buffer (30));
Pixel_7: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (9), RGB_buffer (29), RGB_buffer (28), RGB_buffer (27));
Pixel_8: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (8), RGB_buffer (26), RGB_buffer (25), RGB_buffer (24));
Pixel_9: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (7), RGB_buffer (23), RGB_buffer (22), RGB_buffer (21));
Pixel_10: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (6), RGB_buffer (20), RGB_buffer (19), RGB_buffer (18));
Pixel_11: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (5), RGB_buffer (17), RGB_buffer (16), RGB_buffer (15));
Pixel_12: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (4), RGB_buffer (14), RGB_buffer (13), RGB_buffer (12));
Pixel_13: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (3), RGB_buffer (11), RGB_buffer (10), RGB_buffer (9));
Pixel_14: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (2), RGB_buffer (8), RGB_buffer (7), RGB_buffer (6));
Pixel_15: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (1), RGB_buffer (5), RGB_buffer (4), RGB_buffer (3));
Pixel_16: Pixel_of_string
		port map (CLK, Buffer_signal (23 downto 0), WR_to_pix (0), RGB_buffer (2), RGB_buffer (1), RGB_buffer (0));

end Structural;

