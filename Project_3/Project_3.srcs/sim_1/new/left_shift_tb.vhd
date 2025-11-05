library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftLeft_tb is
end entity ShiftLeft_tb;

architecture tb of ShiftLeft_tb is
    component ShiftLeft
        generic (
            WIDTH_IN  : integer := 16;
            WIDTH_OUT : integer := 16;
            SHIFT_SIZE : integer := 2
        );
        port (
            data_in  : in  unsigned(WIDTH_IN-1 downto 0);
            data_out : out unsigned(WIDTH_OUT-1 downto 0)
        );
    end component;

    signal data_in  : unsigned(15 downto 0) := (others => '0');
    signal data_out : unsigned(15 downto 0);

begin
    dut: ShiftLeft
        generic map (
            WIDTH_IN  => 16,
            WIDTH_OUT => 16,
            SHIFT_SIZE => 2
        )
        port map (
            data_in  => data_in,
            data_out => data_out
        );

    stim_proc: process
    begin
        data_in <= to_unsigned(1, 16);
        wait for 10 ns;
        
        data_in <= to_unsigned(5, 16);
        wait for 10 ns;

        data_in <= to_unsigned(16, 16);
        wait for 10 ns;

        data_in <= to_unsigned(1023, 16);
        wait for 10 ns;

        data_in <= (others => '1');
        wait for 10 ns;

        wait;
    end process;
end architecture;
