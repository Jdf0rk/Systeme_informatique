
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:48:52 03/08/2016 
-- Design Name: 
-- Module Name:    compteur_8bits - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity compteur_8bits is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (7 downto 0);
           LOAD : in  STD_LOGIC;
           SENS : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (7 downto 0);
           EN : in  STD_LOGIC);
end compteur_8bits;

architecture Behavioral of compteur_8bits is
  
-- définition de signaux
	signal mem : STD_LOGIC_VECTOR (7 downto 0); --correspond au compteur
  
begin

--domaine concurrent;
	Dout <= mem;

	incrementation : process (CLK) is 
		-- définition de signaux locaux entre is et begin
	
		begin
		--tester si l'horloge est à 1, entre simple guillemet on peut avoir 0 ou 1 et 
		--pour le compteur il faut mettre entre double guillemets
		-- d'abord synchroniser avec l'horloge puis on peut faire le reset
			if CLK='1' then -- mméthode différente dans le poly
				if RST ='0' then
					mem <= x"00";
				elsif EN ='1' then --on peut commencer à compter
					if LOAD='1' then
						--mem <= DIN; équivalent aux deux lignes de ci-dessous
						mem(7 downto 4) <= DIN(7 downto 4);
						mem(3 downto 0) <= DIN(3 downto 0);
					elsif SENS ='1' then
						mem <= mem + x"01"; --il faut des vecteurs de même taille de chaque côté de l'affectation
					else 
						mem <= mem - x"01";
					end if;
					
				end if;
			end if;		
		end process; 
end Behavioral;

