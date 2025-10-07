----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Dustin Trimmer
-- 
-- Create Date: 10/06/2025 08:09:03 PM
-- Design Name: 
-- Module Name: Registers - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity Registers is
    Port (
        clk    : in  STD_LOGIC;
        RegWr  : in  STD_LOGIC;
        Ra, Rb, Rw : in  STD_LOGIC_VECTOR(4 downto 0);
        busW   : in  STD_LOGIC_VECTOR(31 downto 0);
        busA, busB : out STD_LOGIC_VECTOR(31 downto 0)
    );
end Registers;

architecture Behavioral of Registers is
    type reg_array is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if RegWr = '1' then
                regs(to_integer(unsigned(Rw))) <= busW;
            end if;
        end if;
    end process;

    busA <= regs(to_integer(unsigned(Ra)));
    busB <= regs(to_integer(unsigned(Rb)));
end Behavioral;
