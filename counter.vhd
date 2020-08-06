----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:17:59 10/14/2018 
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
	Port(
		Seg_AN	:out std_logic_vector(3 downto 0);
		Seg7		:out std_logic_vector(6 downto 0);
		CLK		:in std_logic
	);
end test;

architecture Behavioral of test is
	signal number	:std_logic_vector(15 downto 0);
	signal mux_select	:std_logic_vector(1 downto 0);
	signal digit	:std_logic_vector(3 downto 0);
	signal anode_activate	:std_logic_vector(3 downto 0);
	signal counter	:natural range 0 to 4;
	signal select_counter	:natural range 0 to 4;
	constant c_cnt_200hz	:natural	:= 87500;
	signal r_cnt_200hz	:natural	range 0 to c_cnt_200hz;
	constant c_cnt_1hz	:natural	:= 17500000;
	signal r_cnt_1hz	:natural range 0 to c_cnt_1hz;
begin
--	number <= x"1234";

	process(mux_select)
	begin
		case mux_select is
			when "00" => digit <= number(3 downto 0);
			when "01" => digit <= number(7 downto 4);
			when "10" => digit <= number(11 downto 8);
			when others => digit <= number(15 downto 12);
		end case;
	end process;

	process(digit)
	begin
		case digit is
			when "0000" => Seg7 <= "1000000";
			when "0001" => Seg7 <= "1111001";
			when "0010" => Seg7 <= "0100100";
			when "0011" => Seg7 <= "0110000";
			when "0100" => Seg7 <= "0011001";
			when "0101" => Seg7 <= "0010010";
			when "0110" => Seg7 <= "0000010";
			when "0111" => Seg7 <= "1111000";
			when "1000" => Seg7 <= "0000000";
			when "1001" => Seg7 <= "0010000";
			when x"A" => Seg7 <= "0100000";
			when x"B" => Seg7 <= "0000011";
			when x"C" => Seg7 <= "1000110";
			when x"D" => Seg7 <= "0100001";
			when x"E" => Seg7 <= "0000110";
			when others => Seg7 <= "0001110";
		end case;
	end process;

	process(CLK)
	begin
		if rising_edge(CLK) then
			if r_cnt_200hz = c_cnt_200hz - 1 then
				if counter = 4 then
					counter <= 0;
				else
					counter <= counter + 1;
				end if;
				r_cnt_200hz <= 0;
			else
				r_cnt_200hz <= r_cnt_200hz + 1;
			end if;
		end if;
	end process;
	
	process(CLK)
	begin
		if rising_edge(CLK) then
			if r_cnt_1hz = c_cnt_1hz - 1 then
				r_cnt_1hz <= 0;
				number <= std_logic_vector(unsigned(number) + 1);
			else
				r_cnt_1hz <= r_cnt_1hz + 1;
			end if;
		end if;
	end process;
	
	process(counter)
	begin
		case counter is
			when 1 => anode_activate <= "1110";
						mux_select <= "00";
			when 2 => anode_activate <= "1101";
						mux_select <= "01";
			when 3 => anode_activate <= "1011";
						mux_select <= "10";
			when others => anode_activate <= "0111";
								mux_select <= "11";
		end case;
	end process;
		
	Seg_AN(3 downto 0) <= anode_activate(3 downto 0);
end Behavioral;

