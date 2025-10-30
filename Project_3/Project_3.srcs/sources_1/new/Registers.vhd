library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Registers is
    Port (
        clk    : in  STD_LOGIC;
        RegWr  : in  unsigned(15 downto 0);
        Ra, Rb, Rw : in  unsigned(2 downto 0);
        busW   : in  unsigned(15 downto 0);
        busA, busB : out unsigned(15 downto 0)
    );
end Registers;

architecture Behavioral of Registers is
    type reg_array is array (15 downto 0) of unsigned(15 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if(rising_edge(clk)) then 
            case RegWr is
                when '1' => 
                    regs(to_integer(Rw)) <= busW;
                when others =>
            end case;
        end if;
    end process;
    busA <= regs(to_integer(Ra)); 
    busB <= regs(to_integer(Rb));
end Behavioral;
