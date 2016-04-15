----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:09:41 03/30/2016 
-- Design Name: 
-- Module Name:    data_memory - Behavioral 
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

entity data_memory is
    Port ( adresse : in  STD_LOGIC_VECTOR (7 downto 0);
           dIN : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           dOUT : out  STD_LOGIC_VECTOR (7 downto 0));
end data_memory;

architecture Behavioral of data_memory is

	type addr_data is array(0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
	signal data : addr_data := ((others => (others=>'0')));

begin
	data_mem : process (CLK) is 

		
		begin

		if CLK='1' then
			if RST ='0' then
				data<=(others =>(others=>'0'));
			elsif RW='1' then
				dOUT(7 downto 0) <= data(conv_integer(adresse(7 downto 0)));
			elsif RW='0' then
				data(conv_integer(adresse(7 downto 0)))<=dIN;
			end if;
		end if;
	end process;	
end Behavioral;

