library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALUControl_tb is
end entity;

architecture Behavioral of ALUControl_tb is

    component ALUControl
        port (
            ALUOp  : in  unsigned(3 downto 0);
            func   : in  unsigned(2 downto 0);
            ALUctr : out unsigned(3 downto 0)
        );
    end component;

    signal ALUOp_tb  : unsigned(3 downto 0) := (others => '0');
    signal func_tb   : unsigned(2 downto 0) := (others => '0');
    signal ALUctr_tb : unsigned(3 downto 0);

begin

    UUT: ALUControl
        port map (
            ALUOp  => ALUOp_tb,
            func   => func_tb,
            ALUctr => ALUctr_tb
        );

    stim_proc: process
    begin

        -- Test R-type ALUOp = 0000
        ALUOp_tb <= "0000";
        for i in 0 to 6 loop
            func_tb <= to_unsigned(i, 3);
            wait for 10 ns;
        end loop;

        -- Test R-type ALUOp = 0001
        ALUOp_tb <= "0001";
        for i in 0 to 7 loop
            func_tb <= to_unsigned(i, 3);
            wait for 10 ns;
        end loop;

        -- Test I-type
        for op in 2 to 7 loop
            ALUOp_tb <= to_unsigned(op, 4);
            func_tb <= "000"; 
            wait for 10 ns;
        end loop;

        -- Test an invalid case
        ALUOp_tb <= "1111";
        func_tb  <= "111";
        wait for 10 ns;
        wait;
    end process;

end architecture Behavioral;
