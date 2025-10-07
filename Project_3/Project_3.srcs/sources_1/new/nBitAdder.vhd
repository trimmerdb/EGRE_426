----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Dustin Trimmer
-- 
-- Create Date: 10/06/2025 08:09:03 PM
-- Design Name: 
-- Module Name: nBitAdder - Behavioral
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

entity nBitAdder is
    generic ( N : integer := 32 );
    Port (
        A, B : in  STD_LOGIC_VECTOR(N-1 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR(N-1 downto 0);
        Cout : out STD_LOGIC
    );
end nBitAdder;

architecture Behavioral of nBitAdder is
    component Full_Adder
        Port (
            a, b, cin : in  STD_LOGIC;
            sum, cout : out STD_LOGIC
        );
    end component;

    signal carry : STD_LOGIC_VECTOR(N downto 0);
begin
    carry(0) <= Cin;
    Cout <= carry(N);

    gen_adders : for i in 0 to N-1 generate
        FA: Full_Adder
            port map (
                a => A(i),
                b => B(i),
                cin => carry(i),
                sum => Sum(i),
                cout => carry(i+1)
            );
    end generate;
end Behavioral;
