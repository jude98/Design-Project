----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:54:14 10/01/2018 
-- Design Name: 
-- Module Name:    switch_LED - Behavioral 
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

entity switch_LED is
    Port ( switch_0 : in  STD_LOGIC;
           switch_1 : in  STD_LOGIC;
           LED_0 : out  STD_LOGIC;
           LED_1 : out  STD_LOGIC);
end switch_LED;

architecture Behavioral of switch_LED is

begin

LED_0 <= switch_0 or switch_1;
LED_1 <= switch_0 and switch_1;

end Behavioral;

