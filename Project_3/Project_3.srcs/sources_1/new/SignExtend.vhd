library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtend is
    port (
        In6  : in  unsigned(5 downto 0);
        Out16 : out unsigned(16 downto 0)
    );
end entity;

architecture Behavioral of SignExtend is
begin
    Out16 <= resize(In6, 16);
end architecture Behavioral;
