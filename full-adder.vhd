----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:57:03 08/14/2018 
-- Design Name: 
-- Module Name:    full-adder - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_adder is
	port(
		x: in std_logic;
		y: in std_logic;
		z: in std_logic;
		s: out std_logic;
		c: out std_logic
		);
end full_adder;

architecture Behavioral of full_adder is

begin

	s <= x xor y xor z;
	c <= ((x xor y) and z) or (x and y);

end Behavioral;

