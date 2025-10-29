library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
    generic (
        ADDR_WIDTH : integer := 16
    );
    port (
        clk   : in  std_logic;
        addr  : in  unsigned(15 downto 0);
        instr : out unsigned(15 downto 0)
    );
end entity InstructionMemory;

architecture Behavioral of InstructionMemory is
    constant DEPTH : integer := 256;

    type rom_type is array (0 to DEPTH - 1) of unsigned(15 downto 0);

    signal ROM : rom_type := (
        others => (others => '0')
    );

begin
    process(clk)
        variable index : integer;
    begin
        if rising_edge(clk) then
            index := to_integer(addr);
            if index >= 0 and index < DEPTH then
                instr <= ROM(index);
            else
                instr <= (others => '0');
            end if;
        end if;
    end process;

end architecture Behavioral;
