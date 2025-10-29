library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtend_tb is
end entity;

architecture tb of SignExtend_tb is
    component SignExtend
        port (
            In16  : in  unsigned(5 downto 0);
            Out32 : out unsigned(15 downto 0)
        );
    end component;

    signal In16  : unsigned(5 downto 0) := (others => '0');
    signal Out32 : unsigned(15 downto 0);

begin
    uut: SignExtend
        port map (
            In16  => In16,
            Out32 => Out32
        );

    stim_proc: process
    begin
        In16 <= to_unsigned(0, 6);
        wait for 10 ns;

        In16 <= to_unsigned(1, 6);
        wait for 10 ns;

        In16 <= to_unsigned(255, 6);
        wait for 10 ns;

        In16 <= to_unsigned(32768, 6);
        wait for 10 ns;

        In16 <= to_unsigned(65535, 6);
        wait for 10 ns;

        wait;
    end process;
end architecture;
