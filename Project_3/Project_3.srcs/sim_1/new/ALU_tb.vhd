----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2025 09:49:19 PM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is

    -- Component Under Test
    component ALU
        Port (
            A, B     : in  STD_LOGIC_VECTOR(31 downto 0);
            ALUctr   : in  STD_LOGIC_VECTOR(2 downto 0);
            Result   : out STD_LOGIC_VECTOR(31 downto 0);
            Zero, Overflow, Carryout : out STD_LOGIC
        );
    end component;

    -- Signals
    signal A, B, Result : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal ALUctr : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal Zero, Overflow, Carryout : STD_LOGIC := '0';

begin
    --------------------------------------------------------------------
    -- DUT Instance
    --------------------------------------------------------------------
    DUT: ALU
        port map (
            A => A,
            B => B,
            ALUctr => ALUctr,
            Result => Result,
            Zero => Zero,
            Overflow => Overflow,
            Carryout => Carryout
        );

    --------------------------------------------------------------------
    -- Stimulus Process
    --------------------------------------------------------------------
    stim_proc: process
    begin
        ----------------------------------------------------------------
        -- Test mode "000" (ADD)
        ----------------------------------------------------------------
        ALUctr <= "000";
        A <= x"00000005"; B <= x"00000003"; wait for 10 ns;


        A <= x"7FFFFFFF"; B <= x"00000001"; wait for 10 ns;


        A <= x"11111111"; B <= x"22222222"; wait for 10 ns;


        ----------------------------------------------------------------
        -- Test mode "001" (SUB)
        ----------------------------------------------------------------
        ALUctr <= "001";
        A <= x"0000000A"; B <= x"00000003"; wait for 10 ns;


        A <= x"00000003"; B <= x"0000000A"; wait for 10 ns;

        A <= x"FFFFFFFF"; B <= x"00000001"; wait for 10 ns;

        ----------------------------------------------------------------
        -- Test mode "010" (AND)
        ----------------------------------------------------------------
        ALUctr <= "010";
        A <= x"F0F0F0F0"; B <= x"0F0F0F0F"; wait for 10 ns;


        A <= x"AAAAAAAA"; B <= x"55555555"; wait for 10 ns;
        A <= x"FFFFFFFF"; B <= x"0000FFFF"; wait for 10 ns;

        ----------------------------------------------------------------
        -- Test mode "011" (OR)
        ----------------------------------------------------------------
        ALUctr <= "011";
        A <= x"F0F0F0F0"; B <= x"0F0F0F0F"; wait for 10 ns;

        A <= x"AAAA0000"; B <= x"0000BBBB"; wait for 10 ns;
        A <= x"00000000"; B <= x"FFFFFFFF"; wait for 10 ns;

        ----------------------------------------------------------------
        -- Test mode "100" (Logical Left Shift)
        ----------------------------------------------------------------
        ALUctr <= "100";
        A <= x"00000001"; B <= x"00000000"; wait for 10 ns;

        A <= x"80000000"; wait for 10 ns;
        A <= x"0F0F0F0F"; wait for 10 ns;

        ----------------------------------------------------------------
        -- Test mode "101" (Logical Right Shift)
        ----------------------------------------------------------------
        ALUctr <= "101";
        A <= x"00000002"; B <= x"00000000"; wait for 10 ns;

        A <= x"80000000"; wait for 10 ns;
        A <= x"FFFFFFFF"; wait for 10 ns;

        ----------------------------------------------------------------
        -- Test mode "110" (Arithmetic Left Shift)
        ----------------------------------------------------------------
        ALUctr <= "110";
        A <= x"00000001"; B <= x"00000000"; wait for 10 ns;

        A <= x"80000000"; wait for 10 ns;
        A <= x"7FFFFFFF"; wait for 10 ns;

        ----------------------------------------------------------------
        -- Test mode "111" (Arithmetic Right Shift)
        ----------------------------------------------------------------
        ALUctr <= "111";
        A <= x"80000000"; B <= x"00000000"; wait for 10 ns;

        A <= x"00000002"; wait for 10 ns;
        A <= x"FFFFFFFF"; wait for 10 ns;

        ----------------------------------------------------------------
        -- End simulation
        ----------------------------------------------------------------
        wait;
    end process;
end Behavioral;
