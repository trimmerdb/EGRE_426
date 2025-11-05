library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory_tb is
end entity;

architecture tb of InstructionMemory_tb is

    component InstructionMemory
        port (
            clk   : in  std_logic;
            addr  : in  unsigned(15 downto 0);
            instr : out unsigned(15 downto 0)
        );
    end component;

    signal clk   : std_logic := '0';
    signal addr  : unsigned(15 downto 0) := (others => '0');
    signal instr : unsigned(15 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin
    uut: InstructionMemory
        port map (
            clk   => clk,
            addr  => addr,
            instr => instr
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD/2;
            clk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;


    stim_proc : process
    begin

        wait for 2 * CLK_PERIOD;
        wait for CLK_PERIOD;

        addr <= to_unsigned(0, 16);
        wait for CLK_PERIOD;

        addr <= to_unsigned(1, 16);
        wait for CLK_PERIOD;

        addr <= to_unsigned(2, 16);
        wait for CLK_PERIOD;

        addr <= to_unsigned(3, 16);
        wait for CLK_PERIOD;

        addr <= to_unsigned(500, 16);
        wait for CLK_PERIOD;

        wait for 2 * CLK_PERIOD;

        wait;
    end process;

end architecture;
