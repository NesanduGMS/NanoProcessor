----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2024 11:53:28 PM
-- Design Name: 
-- Module Name: adder_4_bit - Behavioral
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

entity adder_4_bit is
    Port ( A : in STD_LOGIC_Vector(3 downto 0);
           S : out STD_LOGIC_vector(3 downto 0));
end adder_4_bit;

architecture Behavioral of adder_4_bit is

  component FA 
    port ( 
      A: in std_logic; 
      B: in std_logic; 
      C_in: in std_logic; 
      S: out std_logic; 
      C_out: out std_logic
    ); 
  end component; 

  signal FA0_C, FA1_C, FA2_C, FA3_C : std_logic; 

begin

  FA_0 : FA 
    port map ( 
      A => A(0), 
      B => '1', 
      C_in => '0', 
      S => S(0), 
      C_Out => FA0_C
    ); 
  FA_1 : FA 
    port map ( 
      A => A(1), 
      B => '0', 
      C_in => FA0_C, 
      S => S(1), 
      C_Out => FA1_C
    );
  FA_2 : FA 
    port map ( 
      A => A(2), 
      B => '0', 
      C_in => FA1_C, 
      S => S(2), 
      C_Out => FA2_C
    );
  FA_3 : FA 
    port map ( 
      A => A(3), 
      B => '0', 
      C_in => FA2_C, 
      S => S(3), 
      C_Out => FA3_C
    );

end Behavioral;

