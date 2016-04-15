----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:12:17 03/30/2016 
-- Design Name: 
-- Module Name:    ins_memory - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ins_memory is
    Port ( adresse : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           dOUT : out  STD_LOGIC_VECTOR (31 downto 0));
end ins_memory;

architecture Behavioral of ins_memory is

	type addr_ins is array(0 to 255) of STD_LOGIC_VECTOR (31 downto 0);
	signal ins : addr_ins := ((others => (others=>'1')));

begin
	ins_mem : process (CLK) is 

		begin

		if CLK='1' then
				dOUT<= ins(conv_integer(adresse(7 downto 0)));
		end if;		
	end process;	
end Behavioral;

