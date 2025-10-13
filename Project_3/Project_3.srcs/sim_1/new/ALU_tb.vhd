library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is
    component ALU
        Port (
            A, B     : in  unsigned(31 downto 0);
            ALUctr   : in  unsigned(3 downto 0);
            Result   : out unsigned(31 downto 0);
            Zero, Overflow, Carryout : out STD_LOGIC
        );
    end component;

    signal A, B, Result : unsigned(31 downto 0) := (others => '0');
    signal ALUctr : unsigned(3 downto 0) := (others => '0');
    signal Zero, Overflow, Carryout : STD_LOGIC := '0';

begin
    DUT: ALU
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
        A <= to_unsigned(5, 32); B <= to_unsigned(3, 32); wait for 10 ns;
        report "ADD: 5+3=" & integer'image(to_integer(Result));

        -- SUB
        ALUctr <= "0001";
        A <= to_unsigned(10, 32); B <= to_unsigned(3, 32); wait for 10 ns;
        report "SUB: 10-3=" & integer'image(to_integer(Result));

        -- AND
        ALUctr <= "0010";
        A <= x"F0F0F0F0"; B <= x"0F0F0F0F"; wait for 10 ns;
        report "AND Result: " & integer'image(to_integer(Result));

        -- OR
        ALUctr <= "0011";
        A <= x"F0F0F0F0"; B <= x"0F0F0F0F"; wait for 10 ns;
        report "OR Result: " & integer'image(to_integer(Result));

        -- LSHIFT
        ALUctr <= "0100";
        A <= to_unsigned(1, 32); wait for 10 ns;
        report "LSHIFT: " & integer'image(to_integer(Result));

        -- RSHIFT
        ALUctr <= "0101";
        A <= to_unsigned(2, 32); wait for 10 ns;
        report "RSHIFT: " & integer'image(to_integer(Result));

        -- Arith LSHIFT
        ALUctr <= "0110";
        A <= B"1111_1111_1111_1111_1111_1111_1111_1011"; wait for 10 ns;
        report "ARITH LSHIFT: " & integer'image(to_integer(Result));
      
        -- Arith RSHIFT
        ALUctr <= "0111";
        A <= B"1111_1111_1111_1111_1111_1111_1111_1011"; wait for 10 ns;
        report "ARITH RSHIFT: " & integer'image(to_integer(Result));

        -- MULTIPLICATION
        ALUctr <= "1000";
        A <= to_unsigned(2, 32);  -- multiplicand
        B <= to_unsigned(3, 32);  -- multiplier
        wait for 20 ns;
        report "MULT: 2 * 3 = " & integer'image(to_integer(Result));
        
        wait;
    end process;
end Behavioral;
