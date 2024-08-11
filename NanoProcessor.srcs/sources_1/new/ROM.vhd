----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2024 11:00:28 AM
-- Design Name: 
-- Module Name: ROM - Behavioral
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
use ieee.numeric_std.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (11 downto 0));
end ROM;

architecture Behavioral of ROM is
type rom_type is array (0 to 15) of std_logic_vector(11 downto 0);
 
    signal program_ROM : rom_type := (
--        "100010000001",  --MOVI R1,1
--        "100100000010", --MOVI R2,2
--        "100110000011", --MOVI R3,3
--        "101110000000", --MOVI R7,0 
--        "001110010000", --ADD R7,R1
--        "001110100000", --ADD R7,R2
--        "001110110000", --ADD R7,R3
--        "110000000111",  --JZR R0,7 
        "101110000000", --MOVI R7,0
        "100010000001", --MOVI R1,1
        "001110010000", --ADD R7,R1
        "101110000011", --MOVI R7,3
        "101110000100", --MOVI R7,4
        "101110000101", --MOVI R7,5
        "101110000110", --MOVI R7,6
        "101110000111", --MOVI R7,7
        "101110001000", --MOVI R7,8
        "101110001001", --MOVI R7,9
        "101110001010", --MOVI R7,10
        "101110001011", --MOVI R7,11
        "101110001100", --MOVI R7,12
        "101110001101", --MOVI R7,13
        "101110001110", --MOVI R7,14
        "101110001111" --MOVI R7,15
    );
begin
data <= program_ROM(to_integer(unsigned(address)));
end Behavioral;
