----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2023 14:10:49
-- Design Name: 
-- Module Name: Reg - Behavioral
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

entity Reg is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0):="0000";
           reset : in std_logic);
end Reg;

architecture Behavioral of Reg is

begin
process(Clk)
begin
--    if (rising_edge(Clk)) then -- respond when clock rises
--        if En = '1' then -- Enable should be set
--            Q <= D;
--        end if;
--        if reset = '1' then
--            Q <="0000";
--        end if;
--    end if;
    if reset = '0' then
        if (rising_edge(Clk)) then
            if En = '1' then
                Q <= D;
            end if;
        end if;
   else
   Q <="0000";
   end if;
   
end process;

end Behavioral;
