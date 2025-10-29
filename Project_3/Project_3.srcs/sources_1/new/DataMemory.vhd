library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
    generic (
        MEM_SIZE : integer := 256  
    );
    port (
        clk      : in  STD_LOGIC;
        MemRead  : in  STD_LOGIC;
        MemWrite : in  STD_LOGIC;
        Address  : in  STD_LOGIC_VECTOR(31 downto 0);
        WriteData: in  STD_LOGIC_VECTOR(31 downto 0);
        ReadData : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture Behavioral of DataMemory is
    type mem_array is array (0 to MEM_SIZE-1) of STD_LOGIC_VECTOR(31 downto 0);
    signal memory : mem_array := (others => (others => '0'));
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
