----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2024 06:46:59 PM
-- Design Name: 
-- Module Name: TB_Microprocessor - Behavioral
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

entity TB_Microprocessor is
--  Port ( );
end TB_Microprocessor;

architecture Behavioral of TB_Microprocessor is

component NanoProcessor port(
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Reg7_Seg : out STD_LOGIC_VECTOR (6 downto 0);
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           Reg_7_Out : out STD_LOGIC_VECTOR (3 downto 0)
           );
           
end component;

SIGNAL Clk,Reset,Zero,Overflow  : std_logic := '0';
SIGNAL Reg7_Seg: std_logic_vector(6 downto 0);
SIGNAL Reg_7_Out: std_logic_vector(3 downto 0);


begin 

UUT : NanoProcessor port map(
           Clk => Clk,
           Reset => Reset,
           Reg7_Seg => Reg7_Seg,
           Zero => Zero,
           Overflow => Overflow,
--           Anode => Anode,
           Reg_7_Out => Reg_7_Out
          
);


process
begin
    Clk <= '0';
    wait for 5ns;
    
    Clk <= '1';
    wait for 5ns;  
end process;     

process
begin
    Reset <= '1';
    wait for 100ns;
    Reset <= '0';
    wait;

end process;
    
end Behavioral;
