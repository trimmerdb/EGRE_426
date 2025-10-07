----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2025 09:34:20 PM
-- Design Name: 
-- Module Name: Full_Adder_TB - Behavioral
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

entity Full_Adder_tb is
end Full_Adder_tb;

architecture Behavioral of Full_Adder_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component Full_Adder
        Port (
            a, b, cin : in  STD_LOGIC;
            sum, cout : out STD_LOGIC
        );
    end component;

    -- Signals to connect to UUT
    signal a, b, cin : STD_LOGIC := '0';
    signal sum, cout : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Full_Adder
        Port map (
            a => a,
            b => b,
            cin => cin,
            sum => sum,
            cout => cout
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test all combinations of a, b, cin (000 to 111)
        a <= '0'; b <= '0'; cin <= '0'; wait for 10 ns;
        a <= '0'; b <= '0'; cin <= '1'; wait for 10 ns;
        a <= '0'; b <= '1'; cin <= '0'; wait for 10 ns;
        a <= '0'; b <= '1'; cin <= '1'; wait for 10 ns;
        a <= '1'; b <= '0'; cin <= '0'; wait for 10 ns;
        a <= '1'; b <= '0'; cin <= '1'; wait for 10 ns;
        a <= '1'; b <= '1'; cin <= '0'; wait for 10 ns;
        a <= '1'; b <= '1'; cin <= '1'; wait for 10 ns;

        -- End of simulation
        wait;
    end process;

end Behavioral;