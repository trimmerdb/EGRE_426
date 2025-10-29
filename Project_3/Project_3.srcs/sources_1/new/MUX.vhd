library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2to1 is
    generic (
        N : integer := 16
    );
    port (
        A   : in  STD_LOGIC_VECTOR(N-1 downto 0);
        B   : in  STD_LOGIC_VECTOR(N-1 downto 0);
        Sel : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end entity;

architecture Behavioral of MUX2to1 is
begin
    Y <= A when Sel = '0' else B;
end architecture;
