----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Dustin Trimmer
-- 
-- Create Date: 10/06/2025 08:09:03 PM
-- Design Name: 
-- Module Name: Top_Level - Behavioral
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

entity Top_Level is
    Port (
        clk       : in  STD_LOGIC;
        RegWr     : in  STD_LOGIC;
        Rd, Rs, Rt : in  unsigned(31 downto 0);  -- widened to match TB
        ALUctr    : in  unsigned(2 downto 0);
        Zero, Overflow, Carryout : out STD_LOGIC;
        Result    : out unsigned(31 downto 0)
    );
end Top_Level;

architecture Behavioral of Top_Level is  -- architecture name changed

    -- Internal 32-bit buses
    signal busA, busB, busW : unsigned(31 downto 0);

    -- Component declarations
    component Registers
        Port (
            clk    : in  STD_LOGIC;
            RegWr  : in  STD_LOGIC;
            Ra, Rb, Rw : in  unsigned(4 downto 0);
            busW   : in  unsigned(31 downto 0);
            busA, busB : out unsigned(31 downto 0)
        );
    end component;

    component ALU
        Port (
            A, B    : in  unsigned(31 downto 0);
            ALUctr  : in  unsigned(2 downto 0);
            Result  : out unsigned(31 downto 0);
            Zero, Overflow, Carryout : out STD_LOGIC
        );
    end component;

    -- Extract lower 5 bits of each register index
    signal Rd_5, Rs_5, Rt_5 : unsigned(4 downto 0);

begin

    Rd_5 <= Rd(4 downto 0);
    Rs_5 <= Rs(4 downto 0);
    Rt_5 <= Rt(4 downto 0);

    -- Instantiate Register File
    RF: Registers
        port map (
            clk   => clk,
            RegWr => RegWr,
            Ra    => Rs_5,
            Rb    => Rt_5,
            Rw    => Rd_5,
            busW  => busW,
            busA  => busA,
            busB  => busB
        );

    -- Instantiate ALU
    ALU0: ALU
        port map (
            A        => busA,
            B        => busB,
            ALUctr   => ALUctr,
            Result   => busW,
            Zero     => Zero,
            Overflow => Overflow,
            Carryout => Carryout
        );

    Result <= busW;

end Behavioral;