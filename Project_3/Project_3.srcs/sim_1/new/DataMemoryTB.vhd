library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory_tb is
end entity;

architecture tb of DataMemory_tb is
    component DataMemory
        generic (
            MEM_SIZE : integer := 256
        );
        port (
            clk       : in  std_logic;
            MemRead   : in  std_logic;
            MemWrite  : in  std_logic;
            Address   : in  unsigned(15 downto 0);
            WriteData : in  unsigned(15 downto 0);
            ReadData  : out unsigned(15 downto 0)
        );
    end component;

    signal clk       : std_logic := '0';
    signal MemRead   : std_logic := '0';
    signal MemWrite  : std_logic := '0';
    signal Address   : unsigned(15 downto 0) := (others => '0');
    signal WriteData : unsigned(15 downto 0) := (others => '0');
    signal ReadData  : unsigned(15 downto 0) := (others => '0');

    constant CLK_PERIOD : time := 10 ns;

begin
    uut: DataMemory
        generic map (
            MEM_SIZE => 256
        )
        port map (
            clk       => clk,
            MemRead   => MemRead,
            MemWrite  => MemWrite,
            Address   => Address,
            WriteData => WriteData,
            ReadData  => ReadData
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
        Address   <= to_unsigned(4, 16);
        WriteData <= to_unsigned(10, 16);
        MemWrite  <= '1';
        wait for CLK_PERIOD;
        MemWrite  <= '0';
        wait for CLK_PERIOD;
        MemRead   <= '1';
        wait for CLK_PERIOD;
        MemRead   <= '0';
        wait for CLK_PERIOD;

        Address   <= to_unsigned(100, 16);
        WriteData <= to_unsigned(255, 16);
        MemWrite  <= '1';
        wait for CLK_PERIOD;
        MemWrite  <= '0';
        wait for CLK_PERIOD;
        MemRead   <= '1';
        wait for CLK_PERIOD;
        MemRead   <= '0';
        wait for CLK_PERIOD;

        Address   <= to_unsigned(12, 16);
        MemRead   <= '1';
        wait for CLK_PERIOD;
        MemRead   <= '0';
        wait for 3 * CLK_PERIOD;
        wait;
    end process;

end architecture;
