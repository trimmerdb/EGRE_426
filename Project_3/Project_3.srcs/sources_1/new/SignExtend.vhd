library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtend is
    port (
        In16  : in  unsigned(5 downto 0);
        Out32 : out unsigned(16 downto 0)
    );
end entity;

architecture Behavioral of SignExtend is
begin
    Out32 <= resize(In16, 16);
end architecture Behavioral;
