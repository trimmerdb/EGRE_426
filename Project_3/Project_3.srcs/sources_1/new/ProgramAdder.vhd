library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PCAdder is
    port (
        pc_in  : in  std_logic_vector(31 downto 0);
        pc_out : out std_logic_vector(31 downto 0)
    );
end entity PCAdder;

architecture Behavioral of PCAdder is
begin
    pc_out <= std_logic_vector(unsigned(pc_in) + 2);
end architecture Behavioral;
