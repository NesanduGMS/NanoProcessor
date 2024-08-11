----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 07:46:25 PM
-- Design Name: 
-- Module Name: TB_Program_Counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Program_Counter is
--  Port ( );
end TB_Program_Counter;

architecture Behavioral of TB_Program_Counter is

component Program_Counter is
    Port ( Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (2 downto 0);
           memory_select : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal Reset : STD_LOGIC;
signal memory_select , D : STD_LOGIC_VECTOR (2 downto 0);
signal Clk : std_logic :='0';

begin

UUT : Program_Counter port map (
    Reset => Reset,
    Clk => Clk,
    D => D,
    memory_select => memory_select);
    
process 
begin
         wait for 50 ns;
         Clk <= NOT (Clk);
end process;

process 
begin
    --1
    Reset <= '1';
    
    D <= "001";
    wait for 100ns;
    --2 
    Reset <= '0';
    
    D <= "010";
    wait for 100ns;
    --3
    D <= "011";
    wait for 100ns;
    --4
    D <= "111";
    wait for 100ns;
    --5
    Reset <= '1';
    
    D <= "010";
    wait for 100ns;
    --6
    D <= "111";
    wait for 100ns;
    
    wait;
end process;

end Behavioral;
