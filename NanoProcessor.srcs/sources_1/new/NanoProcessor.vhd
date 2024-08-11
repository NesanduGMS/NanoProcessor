----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2024 04:58:06 PM
-- Design Name: 
-- Module Name: NanoProcessor - Behavioral
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

entity NanoProcessor is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC:='0';
           Reg7_Seg : out STD_LOGIC_VECTOR (6 downto 0);
           Zero : out STD_LOGIC:='0';
           Overflow : out STD_LOGIC:='0';
           Anode : out STD_LOGIC_VECTOR (3 downto 0);
           Reg_7_Out : out STD_LOGIC_VECTOR (3 downto 0)); 
end NanoProcessor;

architecture Behavioral of NanoProcessor is

component Slow_clk port (
    Clk_in : in STD_LOGIC;
    Clk_out : out STD_LOGIC);
end component;

component Register_Bank port(
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
    reset : in std_logic:='0'
);
end component;

component Adder_Subtractor_4bit
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0); --input A
           B : in STD_LOGIC_VECTOR (3 downto 0); --input B
           M : in STD_LOGIC;                     -- Adder Subtractor switch
           S : out STD_LOGIC_VECTOR (3 downto 0);--Output
           C_OUT : out STD_LOGIC;                --Carry or Borrow out
           OVERFLOW: out STD_LOGIC;              --Overflow Flag
           ZERO: out STD_LOGIC                   --Zero Flag
           );                
end component;

component Program_Counter
    Port ( Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           memory_select : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component adder_4_bit is
    Port ( A : in STD_LOGIC_Vector(3 downto 0);
           S : out STD_LOGIC_vector(3 downto 0));
end component;

component MUX_8_to_1
 Port ( 
     R0 : in STD_LOGIC_VECTOR (3 downto 0);
     R1 : in STD_LOGIC_VECTOR (3 downto 0);
     R2 : in STD_LOGIC_VECTOR (3 downto 0);
     R3 : in STD_LOGIC_VECTOR (3 downto 0);
     R4 : in STD_LOGIC_VECTOR (3 downto 0);
     R5 : in STD_LOGIC_VECTOR (3 downto 0);
     R6 : in STD_LOGIC_VECTOR (3 downto 0);
     R7 : in STD_LOGIC_VECTOR (3 downto 0);
     RegSel : in STD_LOGIC_VECTOR (2 downto 0);
     Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Instruction_Decoder
 Port ( 
     InstructionBus : in STD_LOGIC_VECTOR (11 downto 0);--
     RegCheckforJmp : in STD_LOGIC_VECTOR (3 downto 0);--
     RegisterEnable : out STD_LOGIC_VECTOR (2 downto 0);--
     LoadSelect : out STD_LOGIC:='0';
     ImmediateValue : out STD_LOGIC_VECTOR (3 downto 0);--
     RegisterSelect : out STD_LOGIC_VECTOR (2 downto 0);--
     Add_SubSelection : out STD_LOGIC;
     JumpFlag : out STD_LOGIC:='0';
     RCAEN:OUT STD_LOGIC:='0';
     JumpAddress : out STD_LOGIC_VECTOR (3 downto 0):="0000";--
     RegisterSelect2 : out STD_LOGIC_VECTOR (2 downto 0));--
end component;

component MUX_2_to_1_4bit 
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
    I : in STD_LOGIC_VECTOR (3 downto 0);
    LoadSel : in STD_LOGIC;
    S_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component ROM
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component LUT_16_7 is
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal JumpAddress, NextAddress, Count_In, Address, Bank_out_0, Bank_out_1, Bank_out_2,Bank_out_3,Bank_out_4,Bank_out_5,Bank_out_6,Bank_out_7, D, First_Number, Second_Number, Output_Number, ImmediateValue : STD_LOGIC_VECTOR (3 downto 0);
signal Reg_En, RegSel, RegisterEnable,  RegisterSelect2: STD_LOGIC_VECTOR (2 downto 0);
signal Reg_Reset, Mode, Overflow_Temp, Carry_Out, Zero_Out, PC_Reset, LoadSelect, JumpFlag, RCAEN, SlowedClock : STD_LOGIC;
signal InstructionBus: STD_LOGIC_VECTOR (11 downto 0);
signal Reg7_Seg_temp: STD_LOGIC_VECTOR (6 downto 0);


begin
    Anode <= "1110";
    RegisterBank: Register_Bank port map(
        Clk => SlowedClock, 
        Reg_En => RegisterEnable,
        D => D,
        S_out_0 => Bank_out_0,
        S_out_1 => Bank_out_1,
        S_out_2 => Bank_out_2,
        S_out_3 => Bank_out_3,
        S_out_4 => Bank_out_4,
        S_out_5 => Bank_out_5,
        S_out_6 => Bank_out_6,
        S_out_7 => Bank_out_7,
        reset => Reset
    );
    
    AdderSubtractor : Adder_Subtractor_4bit Port map ( 
        A => First_Number,
        B => Second_Number,
        M => Mode,                     
        S => Output_Number,
        C_OUT => Carry_Out,             
        OVERFLOW=> Overflow,           
        ZERO=> Zero             
    );
    
    
    ProgramCounter: Program_Counter Port map( 
        Reset => Reset,
        Clk => SlowedClock,
        D => Count_In,
        memory_select => Address
    );
    
    
    Bit4_Adder: adder_4_bit Port map ( 
        A => Address,
        S => NextAddress
    );
    
     MUX_8_to_1_one: MUX_8_to_1 Port Map( 
         R0 => Bank_out_0,
         R1 => Bank_out_1,
         R2 => Bank_out_2,
         R3 => Bank_out_3,
         R4 => Bank_out_4,
         R5 => Bank_out_5,
         R6 => Bank_out_6,
         R7 => Bank_out_7,
         RegSel => RegisterSelect2,
         Y => First_Number
     );
     
     MUX_8_to_1_two: MUX_8_to_1 Port Map( -- connected to B , so neggate
        R0 => Bank_out_0,
        R1 => Bank_out_1,
        R2 => Bank_out_2,
        R3 => Bank_out_3,
        R4 => Bank_out_4,
        R5 => Bank_out_5,
        R6 => Bank_out_6,
        R7 => Bank_out_7,
        RegSel => RegSel,
        Y => Second_Number
    );
    
    InstructionDecoder : Instruction_Decoder
     Port map ( 
         InstructionBus => InstructionBus,--
         RegCheckforJmp => First_Number,--
         RegisterEnable => RegisterEnable,--
         LoadSelect => LoadSelect,
         ImmediateValue => ImmediateValue,--
         RegisterSelect => RegSel,--
         Add_SubSelection =>  Mode,
         JumpFlag => JumpFlag,
         RCAEN => RCAEN,
         JumpAddress => JumpAddress,--
         RegisterSelect2 => RegisterSelect2
     );
    
    MUX_4bit_counter : MUX_2_to_1_4bit
    Port Map ( 
        I => JumpAddress,
        A => NextAddress,
        LoadSel => JumpFlag,
        S_out => Count_In
    );
    
    MUX_4bit : MUX_2_to_1_4bit 
    Port Map(
        A => Output_Number,
        I => ImmediateValue,
        LoadSel => LoadSelect,
        S_out => D
    );

    RO_M : ROM
        Port Map ( 
        address => Address,
        data => InstructionBus
    );
    
    LUT: LUT_16_7
        Port Map( 
        address => Bank_out_7,
        data => Reg7_Seg_temp);
        
    SlowClk: Slow_clk port Map (
            Clk_in => Clk ,
            Clk_out => SlowedClock);
    
    Reg7_Seg <= Reg7_Seg_temp;
    Reg_7_Out <= Bank_out_7;


end Behavioral;
