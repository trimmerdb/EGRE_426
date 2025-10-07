----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2025 09:43:31 PM
-- Design Name: 
-- Module Name: registers_tb - Behavioral
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

entity Registers_tb is
end Registers_tb;

architecture Behavioral of Registers_tb is

    -- DUT I/O signals
    signal clk   : STD_LOGIC := '0';
    signal RegWr : STD_LOGIC := '0';
    signal Ra, Rb, Rw : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal busW  : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal busA, busB : STD_LOGIC_VECTOR(31 downto 0);

    -- Clock period constant
    constant clk_period : time := 10 ns;

    -- Component declaration
    component Registers
        Port (
            clk    : in  STD_LOGIC;
            RegWr  : in  STD_LOGIC;
            Ra, Rb, Rw : in  STD_LOGIC_VECTOR(4 downto 0);
            busW   : in  STD_LOGIC_VECTOR(31 downto 0);
            busA, busB : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin

    -- Instantiate the DUT
    uut: Registers
        port map (
            clk   => clk,
            RegWr => RegWr,
            Ra    => Ra,
            Rb    => Rb,
            Rw    => Rw,
            busW  => busW,
            busA  => busA,
            busB  => busB
        );

    -- Clock generation
    clk_process : process
    begin
        while TRUE loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        --------------------------------------------------------------------
        -- Test 1: Write to R1 and read it back
        --------------------------------------------------------------------
        RegWr <= '1';
        Rw <= "00001";                      -- Write to register 1
        busW <= x"DEADBEEF";                -- Write data
        wait for clk_period;                -- Rising edge to latch write

        RegWr <= '0';                       -- Disable writing
        Ra <= "00001";                      -- Read register 1
        wait for 5 ns;
        assert (busA = x"DEADBEEF")
            report "FAIL: R1 readback mismatch!" severity error;

        --------------------------------------------------------------------
        -- Test 2: Write to R2, read from R1 and R2
        --------------------------------------------------------------------
        RegWr <= '1';
        Rw <= "00010";                      -- Write to register 2
        busW <= x"12345678";
        wait for clk_period;

        RegWr <= '0';
        Ra <= "00001";                      -- Read R1
        Rb <= "00010";                      -- Read R2
        wait for 5 ns;
        assert (busA = x"DEADBEEF" and busB = x"12345678")
            report "FAIL: Incorrect values on busA/busB!" severity error;

        --------------------------------------------------------------------
        -- Test 3: Try to write when RegWr='0'
        --------------------------------------------------------------------
        RegWr <= '0';
        Rw <= "00010";
        busW <= x"FFFFFFFF";
        wait for clk_period;

        Ra <= "00010";
        wait for 5 ns;
        assert (busA = x"12345678")
            report "FAIL: Write occurred when RegWr='0'!" severity error;

        --------------------------------------------------------------------
        -- Test complete
        --------------------------------------------------------------------
        report "All register tests PASSED." severity note;
        wait;
    end process;

end Behavioral;
