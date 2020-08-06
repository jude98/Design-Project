----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:06:30 08/16/2018 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
	port(
        A,B : in signed(7 downto 0); --input operands
        Op : in signed(2 downto 0); --Operation to be performed
        R : out signed(7 downto 0);  --output of ALU
		  carryout : out std_logic
        );
end alu;
architecture Behavioral of alu is
signal tmp: signed(8 downto 0);
begin
process(A,B,Op)
begin
case Op is
 when "000" => 
 tmp<= ('0' & A) + ('0' & B); --addition 
 when "001" => 
 tmp<= ('0' & A) - ('0' & B); --subtraction
 when "010" =>
 tmp<= ('0' & A) * ('0' & B);	--multiplication
 when "011" =>
 tmp<= ('0' & A) / ('0' & B);	--division 
 when "100" => 
 tmp<= ('0' & A) and ('0' & B); --AND gate 
 when "101" => 
 tmp<= ('0' & A) or ('0' & B); --OR gate 
 when "110" => 
 tmp<= not ('0' & A) ; --NOT gate 
 when "111" => 
 tmp<= ('0' & A) xor ('0' & B); --XOR gate
 when others =>
 NULL;
end case; 	
end process;
R <= tmp(7 downto 0);
carryout <= tmp(8);
end Behavioral;

