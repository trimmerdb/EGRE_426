library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity nBitAdder_tb is
end nBitAdder_tb;

architecture Behavioral of nBitAdder_tb is

    constant N : integer := 32;

    -- Match the DUT's port types exactly
    signal A, B  : unsigned(N-1 downto 0) := (others => '0');
    signal Cin   : STD_LOGIC := '0';
    signal Sum   : unsigned(N-1 downto 0);
    signal Cout  : STD_LOGIC;

    component nBitAdder
        generic ( N : integer := 32 );
        Port (
            A, B : in  unsigned(N-1 downto 0);
            Cin  : in  STD_LOGIC;
            Sum  : out unsigned(N-1 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

begin

    uut: nBitAdder
        generic map ( N => N )
        port map (
            A => A,
            B => B,
            Cin => Cin,
            Sum => Sum,
            Cout => Cout
        );

    stim_proc: process
    begin
        -- Test Case 1
        A   <= to_unsigned(5, N);
        B   <= to_unsigned(3, N);
        Cin <= '0';
        wait for 20 ns;

        -- Test Case 2
        A   <= to_unsigned(5, N);
        B   <= to_unsigned(3, N);
        Cin <= '1';
        wait for 20 ns;

        -- Test Case 3
        A   <= to_unsigned(100000, N);
        B   <= to_unsigned(250000, N);
        Cin <= '0';
        wait for 20 ns;

        -- Test Case 4
        A   <= to_unsigned(2**31 - 1, N);
        B   <= to_unsigned(1, N);
        Cin <= '0';
        wait for 20 ns;

        -- Test Case 5
        A   <= (others => '1');
        B   <= (others => '0');
        Cin <= '1';
        wait for 20 ns;

        wait;
    end process;

end Behavioral;
