----------------------------------------------------------------------------------
--Подсистема доступа к памяти (ПДП) часть 2
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_DC_str is
    Port ( CLK : in  STD_LOGIC;
			  WR_str: out STD_LOGIC;
			  Addr_RD: out  STD_LOGIC_VECTOR (7 downto 0);
	        Enable_str : out  STD_LOGIC_VECTOR (15 downto 0));
end Counter_DC_str;

architecture Behavioral of Counter_DC_str is

signal counter: STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal cnt: STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal Div_CLK: STD_LOGIC;

begin

process (CLK) --divider frequency
variable counter: integer := 10000; 
	begin
		if CLK='1' and CLK'event then
			if counter = 10000 then 
				counter := 0;
				Div_CLK <= '1';
			else 
				counter := counter + 1;
				Div_CLK <= '0';
			end if;
		end if;
	end process;

process (Div_CLK) -- counter string 0-15
	begin
		if Div_CLK='1' and Div_CLK'event then
			counter <= counter + 1;
		end if;
end process; 
	
process(Div_CLK) -- DC_string
begin
   if ( Div_CLK'event and Div_CLK ='1') then 
			case counter is 
				when "0000" => Enable_str <= "1000000000000000";
				when "0001" => Enable_str <= "0100000000000000";
				when "0010" => Enable_str <= "0010000000000000";
				when "0011" => Enable_str <= "0001000000000000";
				when "0100" => Enable_str <= "0000100000000000";
				when "0101" => Enable_str <= "0000010000000000";
				when "0110" => Enable_str <= "0000001000000000";
				when "0111" => Enable_str <= "0000000100000000";
				when "1000" => Enable_str <= "0000000010000000";
				when "1001" => Enable_str <= "0000000001000000";
				when "1010" => Enable_str <= "0000000000100000";
				when "1011" => Enable_str <= "0000000000010000";
				when "1100" => Enable_str <= "0000000000001000";
				when "1101" => Enable_str <= "0000000000000100";
				when "1110" => Enable_str <= "0000000000000010";
				when "1111" => Enable_str <= "0000000000000001";
				when others => Enable_str <= "0000000000000001";
			end case;
      end if;
end process;

process (CLK) -- counter 0-15
variable div: integer := 0;
	begin
		if CLK='1' and CLK'event then
			if div = 100 then
				WR_str <= '1';
			end if;
			
			if div = 200 then
				cnt <= cnt + 1;
				WR_str <= '0';
				div := 0;
			else div := div + 1;
			end if;
		end if;
end process; 

process (counter, cnt)
begin
	Addr_RD (7 downto 4) <= counter;
	Addr_RD (3 downto 0) <= cnt;
end process;

end Behavioral;


----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_decr is
    Port ( WR : in  STD_LOGIC;
           Addr_Low : out  STD_LOGIC_VECTOR (3 downto 0));
end Counter_decr;

architecture Behavioral of Counter_decr is
signal Addr : STD_LOGIC_VECTOR (3 downto 0) := "0000";
begin

process(WR)

begin
	if WR = '0' and WR' event then
		if Addr = "1111" then Addr <= "0000";
		else 	Addr <= Addr + 1;
		end if;
	Addr_Low <= Addr;
	end if;
end process;

end Behavioral;

