library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftLeft is
    generic (
        WIDTH_IN   : integer := 16;
        WIDTH_OUT  : integer := 16;
        SHIFT_SIZE : integer := 1
    );
    port (
        data_in  : in  unsigned(WIDTH_IN-1 downto 0);
        data_out : out unsigned(WIDTH_OUT-1 downto 0)
    );
end entity ShiftLeft;

architecture Behavioral of ShiftLeft is
begin
    data_out <= shift_left(data_in, 1);
end architecture Behavioral;

