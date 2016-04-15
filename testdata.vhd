--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:08:32 04/15/2016
-- Design Name:   
-- Module Name:   /home/djebli/Bureau/Systeme_informatique-master/Compilateur/Banc_memoire/testdata.vhd
-- Project Name:  Banc_memoire
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: data_memory
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testdata IS
END testdata;
 
ARCHITECTURE behavior OF testdata IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT data_memory
    PORT(
         adresse : IN  std_logic_vector(7 downto 0);
         dIN : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         dOUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal adresse : std_logic_vector(7 downto 0) := (others => '0');
   signal dIN : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal dOUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: data_memory PORT MAP (
          adresse => adresse,
          dIN => dIN,
          RW => RW,
          RST => RST,
          CLK => CLK,
          dOUT => dOUT
        );
		  
			adresse <= X"01", x"02" after 19 ns, x"03" after 39 ns, x"01" after 59 ns, x"02" after 79 ns, x"03" after 99 ns;
			RW <= '0', '1' after 59 ns;
			RST <= '1', '0' after 149 ns;
			dIN <= X"11", x"22" after 19 ns, x"33" after 39 ns, x"11" after 59 ns, x"22" after 79 ns, x"33" after 99 ns;
		  

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
