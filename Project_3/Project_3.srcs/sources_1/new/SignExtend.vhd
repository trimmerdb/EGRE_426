library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignExtend is
    port (
        In16  : in  unsigned(15 downto 0);
        Out32 : out unsigned(31 downto 0)
    );
end entity;

architecture Behavioral of SignExtend is
begin
    Out32 <= (15 downto 0 => In16(15)) & In16;
end architecture;
