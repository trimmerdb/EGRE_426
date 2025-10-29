library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftLeft2 is
    generic (
        WIDTH_IN  : integer := 32; 
        WIDTH_OUT : integer := 32   
    );
    port (
        data_in  : in  unsigned(WIDTH_IN-1 downto 0);
        data_out : out unsigned(WIDTH_OUT-1 downto 0)
    );
end entity ShiftLeft2;

architecture Behavioral of ShiftLeft2 is
begin
    data_out <= data_in(WIDTH_IN-3 downto 0) & "00";
end architecture Behavioral;