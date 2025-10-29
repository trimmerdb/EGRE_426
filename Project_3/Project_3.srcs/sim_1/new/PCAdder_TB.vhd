library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PCAdder_tb is
end entity;

architecture tb of PCAdder_tb is
    component PCAdder
        port (
            pc_in  : in  unsigned(15 downto 0);
            pc_out : out unsigned(15 downto 0)
        );
    end component;

    signal pc_in  : unsigned(15 downto 0) := (others => '0');
    signal pc_out : unsigned(15 downto 0);

begin
    uut: PCAdder
        port map (
            pc_in  => pc_in,
            pc_out => pc_out
        );

    stim_proc : process
    begin

        pc_in <= to_unsigned(0, 16);
        wait for 10 ns;

        pc_in <= to_unsigned(10, 16);
        wait for 10 ns;

        pc_in <= to_unsigned(100, 16);
        wait for 10 ns;

        pc_in <= to_unsigned(65535, 16);
        wait for 10 ns;

        wait;
    end process;

end architecture;
