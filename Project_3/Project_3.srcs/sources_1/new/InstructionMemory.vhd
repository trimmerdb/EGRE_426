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
        0  => "0110000000000000",
        1  => "0010000000000001",
        2  => "1110000000000110",
        3  => "0110001001000000",
        4  => "0010001001000001",
        5  => "1110001001000111",
        6  => "0010001001000001",
        7  => "1110001001000100",
        8  => "0110010010000000",
        9  => "0010010010001111",
        10 => "0110011011000000",
        11 => "0010011011001111",
        12 => "1110011011000100",
        13 => "0110100100000000",
        14 => "0110101101000000",
        15 => "0010101101000001",
        16 => "1110101101000100",
        17 => "0110110110000000",
        18 => "0010110110000101",
        19 => "0011110110000001",
        20 => "0010100101000000",
        21 => "0110111111000000",
        22 => "0010111111000001",
        23 => "1110111111001000",
        24 => "1101100111001100",
        25 => "0100100100000100",
        26 => "0000011011010110",
        27 => "0110101101000000",
        28 => "0010101101001111",
        29 => "1110101101000100",
        30 => "0110101101001111",
        31 => "0010101101000010",
        32 => "0110111111000000",
        33 => "0010111111000001",
        34 => "1001110111001011",
        35 => "1101000000101000",
        36 => "0101000000001000",
        37 => "0000001001000101",
        38 => "0110101101000000",
        39 => "0010101101001111",
        40 => "1110101101000100",
        41 => "0110101101001111",
        42 => "1110101101001000",
        43 => "1101000001000000",
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
