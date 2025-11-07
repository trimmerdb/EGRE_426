library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is

    component ALU
        generic ( N : integer := 16 );
        Port (
            A, B     : in  unsigned(N-1 downto 0);
            ALUctr   : in  unsigned(3 downto 0);
            Result   : out unsigned(N-1 downto 0);
            Zero, Overflow, Carryout : out STD_LOGIC
        );
    end component;

    signal A, B, Result : unsigned(15 downto 0) := (others => '0');
    signal ALUctr : unsigned(3 downto 0) := (others => '0');
    signal Zero, Overflow, Carryout : STD_LOGIC := '0';

begin

    DUT: ALU
        generic map (N => 16)
        port map (
            A => A,
            B => B,
            ALUctr => ALUctr,
            Result => Result,
            Zero => Zero,
            Overflow => Overflow,
            Carryout => Carryout
        );


    stim_proc: process
    begin

        -- ADD
        ALUctr <= "0000";
        A <= to_unsigned(5, 16);
        B <= to_unsigned(3, 16);
        wait for 10 ns;

        -- SUB
        ALUctr <= "0001";
        A <= to_unsigned(10, 16);
        B <= to_unsigned(3, 16);
        wait for 10 ns;

        -- AND
        ALUctr <= "0010";
        A <= x"F0F0";
        B <= x"0F0F";
        wait for 10 ns;

        -- OR
        ALUctr <= "0011";
        A <= x"F0F0";
        B <= x"0F0F";
        wait for 10 ns;

        -- Logical Left Shift
        ALUctr <= "0100";
        A <= to_unsigned(1, 16);
        wait for 10 ns;

        -- Logical Right Shift
        ALUctr <= "0101";
        A <= to_unsigned(2, 16);
        wait for 10 ns;

        -- Arithmetic Left Shift
        ALUctr <= "0110";
        A <= to_unsigned(32763, 16);
        wait for 10 ns;

        -- Arithmetic Right Shift
        ALUctr <= "0111";
        A <= to_unsigned(65531, 16);
        wait for 10 ns;

        -- MULTIPLICATION
        ALUctr <= "1000";
        A <= to_unsigned(2, 16);
        B <= to_unsigned(3, 16);
        wait for 20 ns;

        -- DIVISION (valid divide)
        ALUctr <= "1001";
        A <= to_unsigned(10, 16);
        B <= to_unsigned(3, 16);
        wait for 20 ns;

        -- DIVISION (divide by zero)
        ALUctr <= "1001";
        A <= to_unsigned(10, 16);
        B <= to_unsigned(0, 16);
        wait for 20 ns;

        -- XOR
        ALUctr <= "1010";
        A <= x"AAAA";
        B <= x"5555";
        wait for 10 ns;

        -- NOR
        ALUctr <= "1011";
        A <= x"AAAA";
        B <= x"5555";
        wait for 10 ns;

        -- NAND
        ALUctr <= "1100";
        A <= x"AAAA";
        B <= x"5555";
        wait for 10 ns;

        -- XNOR
        ALUctr <= "1101";
        A <= x"AAAA";
        B <= x"5555";
        wait for 10 ns;

        -- HALT (no operation)
        ALUctr <= "1110";
        A <= x"FFFF";
        B <= x"0001";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
