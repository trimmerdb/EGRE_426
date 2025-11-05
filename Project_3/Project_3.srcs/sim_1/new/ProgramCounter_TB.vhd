library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounter_tb is
end entity;

architecture tb of ProgramCounter_tb is
    component ProgramCounter
        generic (
            N : integer := 16
        );
        port (
            clk     : in  std_logic;
            rst     : in  std_logic;
            pc_in   : in  unsigned(N-1 downto 0);
            pc_out  : out unsigned(N-1 downto 0)
        );
    end component;

    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal pc_in  : unsigned(15 downto 0) := (others => '0');
    signal pc_out : unsigned(15 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin
    uut: ProgramCounter
        generic map (
            N => 16
        )
        port map (
            clk     => clk,
            rst     => rst,
            pc_in   => pc_in,
            pc_out  => pc_out
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;


    stim_proc : process
    begin

        rst <= '1';
        wait for 2 * CLK_PERIOD;
        rst <= '0';
        wait for CLK_PERIOD;

        wait for CLK_PERIOD / 2;
        pc_in <= to_unsigned(4, 16);
        wait for CLK_PERIOD; 
        
        wait for CLK_PERIOD / 2;
        pc_in <= to_unsigned(10, 16);
        wait for CLK_PERIOD;

        rst <= '1';
        wait for CLK_PERIOD;
        rst <= '0';
        wait for CLK_PERIOD;

        wait for CLK_PERIOD / 2;
        pc_in <= to_unsigned(255, 16);
        wait for CLK_PERIOD;

        wait;
    end process;

end architecture;
