library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registers_tb is
end Registers_tb;

architecture Behavioral of Registers_tb is
    signal clk   : STD_LOGIC := '0';
    signal RegWr : STD_LOGIC := '0';
    signal Ra, Rb, Rw : unsigned(2 downto 0) := (others => '0');
    signal busW, busA, busB : unsigned(15 downto 0);

    constant clk_period : time := 10 ns;

    component Registers
        Port (
            clk    : in  STD_LOGIC;
            RegWr  : in  STD_LOGIC;
            Ra, Rb, Rw : in  unsigned(2 downto 0);
            busW   : in  unsigned(15 downto 0);
            busA, busB : out unsigned(15 downto 0)
        );
    end component;

begin

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

    clk_process : process
    begin
        while TRUE loop
            clk <= '0'; wait for clk_period/2;
            clk <= '1'; wait for clk_period/2;
        end loop;
    end process;

    stim_proc : process
    begin
        RegWr <= '1';
        Rw <= to_unsigned(1, 3);
        busW <= x"DEAD";
        wait for clk_period;

        RegWr <= '0';
        Ra <= to_unsigned(1, 3);
        wait for clk_period/4;

        RegWr <= '1';
        Rw <= to_unsigned(2, 3);
        busW <= x"1234";
        wait for clk_period;

        RegWr <= '0';
        Ra <= to_unsigned(1, 3);
        Rb <= to_unsigned(2, 3);
        wait for clk_period/4;

        RegWr <= '0';
        Rw <= to_unsigned(2, 3);
        busW <= x"FFFF";
        wait for clk_period;

        Ra <= to_unsigned(2, 3);
        wait for clk_period/4;

        wait;
    end process;

end Behavioral;
