library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
    generic (
        MEM_SIZE : integer := 256  
    );
    port (
        clk      : in  std_logic;
        MemRead  : in  std_logic;
        MemWrite : in  std_logic;
        Address  : in  unsigned(15 downto 0);
        WriteData: in  unsigned(15 downto 0);
        ReadData : out unsigned(15 downto 0)
    );
end entity;

architecture Behavioral of DataMemory is
    type mem_array is array (0 to MEM_SIZE-1) of unsigned(15 downto 0);
    signal memory : mem_array := (
        4 => "0000000100000001",
        8 => "0000000100010000",
        12 => "0000000000010001",
        16 => "0000000011110000",
        20 => "0000000011111111",
        others => (others => '0')
        );
    signal addr_index : integer range 0 to MEM_SIZE-1;
begin
    addr_index <= to_integer(unsigned(Address(9 downto 2))); 

    process(clk)
    begin
        if rising_edge(clk) then
            if MemWrite = '1' then
                memory(addr_index) <= WriteData;
            end if;
        end if;
    end process;

    ReadData <= memory(addr_index) when MemRead = '1' else (others => '0');
end architecture;
