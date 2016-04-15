--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:09:40 04/13/2016
-- Design Name:   
-- Module Name:   /home/djebli/Bureau/Systeme_informatique-master/Compilateur/UAL/test_UAL.vhd
-- Project Name:  UAL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UAL
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
 
ENTITY test_UAL IS
END test_UAL;
 
ARCHITECTURE behavior OF test_UAL IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UAL
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         N : OUT  std_logic;
         O : OUT  std_logic;
         Z : OUT  std_logic;
         C : OUT  std_logic;
         S : OUT  std_logic_vector(7 downto 0);
         Ctrl_Alu : IN  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal At : std_logic_vector(7 downto 0) := (others => '0');
   signal Bt : std_logic_vector(7 downto 0) := (others => '0');
   signal Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal N : std_logic;
   signal O : std_logic;
   signal Z : std_logic;
   signal C : std_logic;
   signal S : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UAL PORT MAP (
          A => At,
          B => Bt,
          N => N,
          O => O,
          Z => Z,
          C => C,
          S => S,
          Ctrl_Alu => Ctrl_Alu
        );
At <= X"01", x"FF" after 19 ns, x"02" after 39 ns, x"01" after 79 ns;
Bt<= x"01",x"08" after 39 ns, x"FF" after 59 ns, x"01" after 79 ns, x"02" after 99 ns;
ctrl_alu <= "000", "001" after 10 ns, "010" after 39 ns, "011" after 79 ns;

END;
