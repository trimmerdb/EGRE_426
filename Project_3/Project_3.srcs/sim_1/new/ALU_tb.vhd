library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is
    component ALU
        Port (
            A, B     : in  unsigned(31 downto 0);
            ALUctr   : in  unsigned(2 downto 0);
            Result   : out unsigned(31 downto 0);
            Zero, Overflow, Carryout : out STD_LOGIC
        );
    end component;

    signal A, B, Result : unsigned(31 downto 0) := "00000000000000000000000000000000";
    signal ALUctr : unsigned(2 downto 0) := "000";
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
        ALUctr <= "000";
        A <= to_unsigned(5, 32); B <= to_unsigned(3, 32); wait for 10 ns;
        report "ADD: 5+3=" & integer'image(to_integer(Result));


        -- SUB
        ALUctr <= "001";
        A <= to_unsigned(10, 32); B <= to_unsigned(3, 32); wait for 10 ns;
        report "SUB: 10-3=" & integer'image(to_integer(Result));


        -- AND
        ALUctr <= "010";
        A <= x"F0F0F0F0"; B <= x"0F0F0F0F"; wait for 10 ns;
        report "AND Result: " & integer'image(to_integer(Result));


        -- OR
        ALUctr <= "011";
        A <= x"F0F0F0F0"; B <= x"0F0F0F0F"; wait for 10 ns;
        report "OR Result: " & integer'image(to_integer(Result));


        -- LSHIFT
        ALUctr <= "100";
        A <= to_unsigned(1, 32); wait for 10 ns;
        report "LSHIFT: " & integer'image(to_integer(Result));
        
        
        -- RSHIFT
        ALUctr <= "101";
        A <= to_unsigned(2, 32); wait for 10 ns;
        report "RSHIFT: " & integer'image(to_integer(Result));


        -- Arith LSHIFT
        ALUctr <= "110";
        A <= B"1111_1111_1111_1111_1111_1111_1111_1011"; wait for 10 ns;
        report "RSHIFT: " & integer'image(to_integer(Result));
      
      
        -- Arith RSHIFT
        ALUctr <= "111";
        A <= B"1111_1111_1111_1111_1111_1111_1111_1011"; wait for 10 ns;
        report "RSHIFT: " & integer'image(to_integer(Result));

        wait;
    end process;
end Behavioral;
