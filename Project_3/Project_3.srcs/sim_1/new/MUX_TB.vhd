library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX2to1_tb is
end entity;

architecture tb of MUX2to1_tb is
    component MUX2to1
        generic (
            N : integer := 16
        );
        port (
            A   : in  unsigned(N-1 downto 0);
            B   : in  unsigned(N-1 downto 0);
            Sel : in  std_logic;
            Y   : out unsigned(N-1 downto 0)
        );
    end component;


    signal A, B, Y : unsigned(15 downto 0) := (others => '0');
    signal Sel     : std_logic := '0';

begin

    uut: MUX2to1
        generic map (
            N => 16
        )
        port map (
            A   => A,
            B   => B,
            Sel => Sel,
            Y   => Y
        );


    stim_proc : process
    begin
        report "Starting MUX2to1 testbench..." severity note;

        -- Test Case 1: Sel = 0 → Expect Y = A
        A   <= to_unsigned(12345, 16);
        B   <= to_unsigned(54321, 16);
        Sel <= '0';
        wait for 10 ns;

        Sel <= '1';
        wait for 10 ns;

        A <= to_unsigned(100, 16);
        B <= to_unsigned(200, 16);
        Sel <= '0';
        wait for 10 ns;

        Sel <= '1';
        wait for 10 ns;

        wait;
    end process;

end architecture;
