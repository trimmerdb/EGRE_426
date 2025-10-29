library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ProgramCounter is
    generic (
        WIDTH : integer := 16
    );
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;
        pc_in   : in  unsigned(WIDTH-1 downto 0);
        pc_out  : out unsigned(WIDTH-1 downto 0)
    );
end entity ProgramCounter;

architecture Behavioral of ProgramCounter is
    signal pc_reg : unsigned(WIDTH-1 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            pc_reg <= (others => '0');
        elsif rising_edge(clk) then
            pc_reg <= pc_in; 
        end if;
    end process;

    pc_out <= pc_reg;
end architecture Behavioral;
