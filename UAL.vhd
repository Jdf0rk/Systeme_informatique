----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:01:22 03/30/2016 
-- Design Name: 
-- Module Name:    UAL - Behavioral 
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           N : out  STD_LOGIC;
           O : out  STD_LOGIC;
           Z : out  STD_LOGIC;
           C : out  STD_LOGIC;
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0));
end UAL;

architecture Behavioral of UAL is

		signal res : std_logic_vector(15 downto 0) := x"0000";

	begin	
		
		incrementation : process (ctrl_alu, a, b)
			
		
			
			begin
				
				case Ctrl_Alu IS
					WHEN "001" =>	--add
						res<= (x"00" & A) + (x"00" & B);
						
					WHEN "011" =>	--sub
						res<= (x"00" & A) - (x"00" & B);

						
					WHEN "010" =>	--mul
						res<= A * B;

					
					WHEN "101" =>	--and
						res<= (x"00" & A) and (x"00" & B);

						
					WHEN "110" =>	--or
						res<= (x"00" & A) or (x"00" & B);

						
					WHEN "111" =>	--xor
						res<= (x"00" & A) xor (x"00" & B);

					
					WHEN others =>
						res<=x"0000";
					
				end case;
	end process;
	
	S<=res(7 downto 0);
	C <= res (8) when Ctrl_Alu="001" else '0';
	O <='0' when res(15 downto 8) =x"0" else '1';
	Z <='1' when res(7 downto 0) =x"0" else '0';
	N <= '1' when A < B and Ctrl_Alu = "011" else '0';

	

	
end Behavioral;

