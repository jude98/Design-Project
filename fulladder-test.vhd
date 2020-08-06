----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:59:26 10/21/2018 
-- Design Name: 
-- Module Name:    test - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test is
	Port(Seg_AN	:out std_logic_vector(3 downto 0);
			Seg7	:out std_logic_vector(6 downto 0);
			SWITCH	:in std_logic_vector(3 downto 0);
			CLK	:in std_logic
			);
end test;

architecture Behavioral of test is
	signal digit_sel	:natural range 0 to 3;
--	signal sel	:natural range 0 to 2;
	signal anode	:std_logic_vector(3 downto 0);
	signal segment	:std_logic_vector(6 downto 0)	:=	(others => '1');
	signal prescaler: STD_LOGIC_VECTOR(16 downto 0) := "11000011010100000";
   signal prescaler_counter: STD_LOGIC_VECTOR(16 downto 0) := (others => '0');
	signal sum	:std_logic;
	signal carry	:std_logic;
begin
	Seg_AN <= anode;
	Seg7 <= segment;
	
--	process(SWITCH(3))
--	begin
----		case sel is
----			when 1 => anode <= "1110";
----			when 2 => anode <= "1101";
----			when others => anode <= "1000";
----		end case;
--		if
--		sum <= SWITCH(0) xor SWITCH(1) xor SWITCH(2);
--		carry <= ((SWITCH(0) xor SWITCH(1)) and SWITCH(2)) or (SWITCH(0) and SWITCH(1));
--	end process;

	process(SWITCH,digit_sel)
	begin
		case digit_sel is
			when 1 => anode <= "1110";
			when 2 => anode <= "1101";
			when 3 => anode <= "1011";
			when others => anode <= "1000";
		end case;
		sum <= SWITCH(0) xor SWITCH(1) xor SWITCH(2);
		carry <= ((SWITCH(0) xor SWITCH(1)) and SWITCH(2)) or (SWITCH(0) and SWITCH(1));
	end process;
--	
--	process(SWITCH(3),sel)
--	begin
--		if SWITCH(3) = '1' then
--			case sel is
--				when 1 => anode <= "1110";
--				when 2 => anode <= "1101";
--				when others => anode <= "1111";
--			end case;
--		end if;
--		sum <= SWITCH(0) xor SWITCH(1) xor SWITCH(2);
--		carry <= ((SWITCH(0) xor SWITCH(1)) and SWITCH(2)) or (SWITCH(0) and SWITCH(1));	
--	end process;
	
	process(anode)
	begin
		case anode is
			when "1110" =>	if SWITCH(3) = '1' then
									if carry = '1' then
										segment <= "1111001";
									else 
										segment <= "1000000";
									end if;
							  else
								  if SWITCH(0) = '1' then
										segment <= "1111001";
								  else
										segment <= "1000000";
								  end if;
							  end if;
			when "1101" => if SWITCH(3) = '1' then
									if sum = '1' then
										segment <= "1111001";
									else 
										segment <= "1000000";
									end if;
							  else
								  if SWITCH(0) = '1' then
										segment <= "1111001";
								  else
										segment <= "1000000";
								  end if;
							  end if;
			when "1011" => if SWITCH(2) = '1' then
									segment <= "1111001";
							  else
									segment <= "1000000";
							  end if;
			when others => segment <= "1111111";
		end case;
	end process;
	
	process(CLK,digit_sel)
	begin
		if rising_edge(CLK) then
			prescaler_counter <= std_logic_vector(unsigned(prescaler_counter) + 1);
			if prescaler_counter = prescaler then
				if digit_sel = 3 then
					digit_sel <= 0;
				else
					digit_sel <= digit_sel + 1;
				end if;
				prescaler_counter <= (others => '0');
			end if;
		end if;
	end process;
--	
--	process(CLK,sel)
--	begin
--		if rising_edge(CLK) then
--			prescaler_counter <= std_logic_vector(unsigned(prescaler_counter) + 1);
--			if prescaler_counter = prescaler then
--				if sel = 2 then
--					sel <= 0;
--				else
--					sel <= sel + 1;
--				end if;
--				prescaler_counter <= (others => '0');
--			end if;
--		end if;
--	end process;
end Behavioral;

