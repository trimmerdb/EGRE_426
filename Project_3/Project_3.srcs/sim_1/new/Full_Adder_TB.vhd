library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder_tb is
end Full_Adder_tb;

architecture Behavioral of Full_Adder_tb is

    -- Component Declaration
    component Full_Adder
        Port (
            a, b, cin : in  STD_LOGIC;
            sum, cout : out STD_LOGIC
        );
    end component;

    -- Signals
    signal a, b, cin : STD_LOGIC := '0';
    signal sum, cout : STD_LOGIC;

begin

    -- Instantiate
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
        -- Test all combinations of a, b, cin
        a <= '0'; b <= '0'; cin <= '0'; wait for 10 ns;
        a <= '0'; b <= '0'; cin <= '1'; wait for 10 ns;
        a <= '0'; b <= '1'; cin <= '0'; wait for 10 ns;
        a <= '0'; b <= '1'; cin <= '1'; wait for 10 ns;
        a <= '1'; b <= '0'; cin <= '0'; wait for 10 ns;
        a <= '1'; b <= '0'; cin <= '1'; wait for 10 ns;
        a <= '1'; b <= '1'; cin <= '0'; wait for 10 ns;
        a <= '1'; b <= '1'; cin <= '1'; wait for 10 ns;
        wait;
    end process;

end Behavioral;