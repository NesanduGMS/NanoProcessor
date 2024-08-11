----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2024 01:07:53 PM
-- Design Name: 
-- Module Name: TB_REG_BANK - Behavioral
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

entity TB_REG_BANK is
--  Port ( );
end TB_REG_BANK;

architecture Behavioral of TB_REG_BANK is

component Register_Bank Port(
           Clk : in STD_LOGIC; 
           Reg_En : in STD_LOGIC_VECTOR (2 downto 0);
           D : in STD_LOGIC_VECTOR (3 downto 0);
           S_out_0 : out STD_LOGIC_VECTOR (3 downto 0);
           S_out_1 : out STD_LOGIC_VECTOR (3 downto 0);
           S_out_2 : out STD_LOGIC_VECTOR (3 downto 0);
           S_out_3 : out STD_LOGIC_VECTOR (3 downto 0);
           S_out_4 : out STD_LOGIC_VECTOR (3 downto 0);
           S_out_5 : out STD_LOGIC_VECTOR (3 downto 0);
           S_out_6 : out STD_LOGIC_VECTOR (3 downto 0);
           S_out_7 : out STD_LOGIC_VECTOR (3 downto 0);
           reset : in std_logic
);
end component;

signal S_out_0,S_out_1,S_out_2,S_out_3,S_out_4,S_out_5,S_out_6,S_out_7,D : std_logic_vector(3 downto 0);
signal reset, Clk : std_logic;
signal Reg_En : STD_LOGIC_VECTOR (2 downto 0);

begin
    
    UUT : Register_Bank Port Map(
           Clk => Clk,
           Reg_En => Reg_En,
           D => D,
           S_out_0 => S_out_0,
           S_out_1 => S_out_1,
           S_out_2 => S_out_2,
           S_out_3 => S_out_3,
           S_out_4 => S_out_4,
           S_out_5 => S_out_5,
           S_out_6 => S_out_6,
           S_out_7 => S_out_7,
           reset => reset
    );
    
    process begin
        Clk <= '0';
        wait for 5ns;
        Clk <= '1';
        wait for 5ns;
    end process;
    
    process begin
    
       reset <= '0';
       Reg_En <= "000";
       D <= "1000";
       wait for 100 ns;
       
       Reg_En <= "001";
       D <= "1010";
       wait for 100 ns;
       
       Reg_En <= "010";
       D <= "0110";    
       wait for 100 ns;
       
       Reg_En <= "011";
       D <= "1111";    
       wait for 100 ns;
           
       Reg_En <= "100";
       D <= "0011";    
       wait for 100 ns;
           
       Reg_En <= "101";
       D <= "1100";    
       wait for 100 ns;
       
       Reg_En <= "110";
       D <= "0100";    
       wait for 100 ns;
       
       
       Reg_En <= "111";
       D <= "0111";    
       wait for 100 ns;  
       
       Reg_En <= "011";
       D <= "0000";    
       wait for 100 ns;
       reset <= '1';
       wait;
       
    
    end process;
end Behavioral;
