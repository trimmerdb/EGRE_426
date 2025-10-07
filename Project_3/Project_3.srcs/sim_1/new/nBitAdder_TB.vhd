----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2025 09:38:30 PM
-- Design Name: 
-- Module Name: nBitAdder_TB - Behavioral
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

entity nBitAdder_tb is
end nBitAdder_tb;

architecture Behavioral of nBitAdder_tb is

    -- Generic width for the adder
    constant N : integer := 32;

    -- DUT signals
    signal A, B  : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal Cin   : STD_LOGIC := '0';
    signal Sum   : STD_LOGIC_VECTOR(N-1 downto 0);
    signal Cout  : STD_LOGIC;

    -- Component declaration for DUT
    component nBitAdder
        generic ( N : integer := 32 );
        Port (
            A, B : in  STD_LOGIC_VECTOR(N-1 downto 0);
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC_VECTOR(N-1 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: nBitAdder
        generic map ( N => N )
        port map (
            A => A,
            B => B,
            Cin => Cin,
            Sum => Sum,
            Cout => Cout
        );

    -- Stimulus process
    stim_proc: process
    begin

        --------------------------------------------------------------------
        -- Test Case 1: Small numbers, no carry-in
        --------------------------------------------------------------------
        A   <= std_logic_vector(to_unsigned(5, N));   -- 0x00000005
        B   <= std_logic_vector(to_unsigned(3, N));   -- 0x00000003
        Cin <= '0';
        wait for 20 ns;

        --------------------------------------------------------------------
        -- Test Case 2: Small numbers with carry-in
        --------------------------------------------------------------------
        A   <= std_logic_vector(to_unsigned(5, N));   -- 0x00000005
        B   <= std_logic_vector(to_unsigned(3, N));   -- 0x00000003
        Cin <= '1';
        wait for 20 ns;

        --------------------------------------------------------------------
        -- Test Case 3: Mid-range numbers
        --------------------------------------------------------------------
        A   <= std_logic_vector(to_unsigned(100000, N));
        B   <= std_logic_vector(to_unsigned(250000, N));
        Cin <= '0';
        wait for 20 ns;

        --------------------------------------------------------------------
        -- Test Case 4: Large numbers (overflow within 32 bits)
        --------------------------------------------------------------------
        A   <= std_logic_vector(to_unsigned(2**31 - 1, N)); -- Max positive signed int
        B   <= std_logic_vector(to_unsigned(1, N));         -- Add 1 → overflow
        Cin <= '0';
        wait for 20 ns;

        --------------------------------------------------------------------
        -- Test Case 5: All ones + 1 (Cout should be 1)
        --------------------------------------------------------------------
        A   <= (others => '1');  -- 0xFFFFFFFF
        B   <= (others => '0');  -- 0x00000000
        Cin <= '1';
        wait for 20 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
