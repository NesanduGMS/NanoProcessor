----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 05:04:48 PM
-- Design Name: 
-- Module Name: Program_Counter - Behavioral
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

entity Program_Counter is
    Port ( Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           memory_select : out STD_LOGIC_VECTOR (3 downto 0));
end Program_Counter;

architecture Behavioral of Program_Counter is

component D_FF is
    Port ( D : in STD_LOGIC;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC;
           Qbar : out STD_LOGIC);
end component;

begin

D_FF0 : D_FF port map (
    D => D(0),
    Res => Reset ,
    Clk => Clk,
    Q => memory_select(0)
    );
    
D_FF1 : D_FF port map (
        D => D(1),
        Res => Reset ,
        Clk => Clk,
        Q => memory_select(1)
        );

D_FF2 : D_FF port map (
    D => D(2),
    Res => Reset ,
    Clk => Clk,
    Q => memory_select(2)
    );
    
D_FF3 : D_FF port map (
        D => D(3),
        Res => Reset ,
        Clk => Clk,
        Q => memory_select(3)
        );

end Behavioral;
