----------------------------------------------------------------------------------
--Дешифратор адреса строки
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DC_Addr is
    Port ( 	CLK: in STD_LOGIC;
				Addr_Bus : in  STD_LOGIC_VECTOR (3 downto 0);
				DC_Addr_Bus : out  STD_LOGIC_VECTOR (15 downto 0));
end DC_Addr;

architecture Behavioral of DC_Addr is

begin

process(CLK)
begin
   if ( CLK'event and CLK ='1') then 
			case Addr_Bus is
				when "0000" => DC_Addr_Bus <= "0000000000000001";
				when "0001" => DC_Addr_Bus <= "0000000000000010";
				when "0010" => DC_Addr_Bus <= "0000000000000100";
				when "0011" => DC_Addr_Bus <= "0000000000001000";
				when "0100" => DC_Addr_Bus <= "0000000000010000";
				when "0101" => DC_Addr_Bus <= "0000000000100000";
				when "0110" => DC_Addr_Bus <= "0000000001000000";
				when "0111" => DC_Addr_Bus <= "0000000010000000";
				when "1000" => DC_Addr_Bus <= "0000000100000000";
				when "1001" => DC_Addr_Bus <= "0000001000000000";
				when "1010" => DC_Addr_Bus <= "0000010000000000";
				when "1011" => DC_Addr_Bus <= "0000100000000000";
				when "1100" => DC_Addr_Bus <= "0001000000000000";
				when "1101" => DC_Addr_Bus <= "0010000000000000";
				when "1110" => DC_Addr_Bus <= "0100000000000000";
				when "1111" => DC_Addr_Bus <= "1000000000000000";
				when others => DC_Addr_Bus <= "0000000000000000";
			end case;
      end if;
end process;

end Behavioral;

