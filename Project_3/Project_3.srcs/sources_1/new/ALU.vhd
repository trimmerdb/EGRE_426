----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Dustin Trimmer
-- 
-- Create Date: 10/06/2025 08:09:03 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A, B     : in  unsigned(31 downto 0);
        ALUctr   : in  unsigned(2 downto 0);
        Result   : out unsigned(31 downto 0);
        Zero, Overflow, Carryout : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is

    -- Constant for width
    constant N : integer := 32;

    -- nBitAdder component
    component nBitAdder
        generic ( N : integer := 32 );
        port (
            A, B  : in  unsigned(N-1 downto 0);
            Cin   : in  STD_LOGIC;
            Sum   : out unsigned(N-1 downto 0);
            Cout  : out STD_LOGIC
        );
    end component;

    -- Internal signals
    signal add_b, add_sum, alu_result : unsigned(N-1 downto 0);
    signal add_cout, add_cin : STD_LOGIC;
    signal sign_a, sign_b, sign_r : STD_LOGIC;

begin
    --------------------------------------------------------------------
    -- Handle ADD / SUB input setup
    --------------------------------------------------------------------
    process(ALUctr, A, B)
    begin
        case ALUctr is
            when "000" =>  -- ADD
                add_b   <= B;
                add_cin <= '0';
            when "001" =>  -- SUB
                add_b   <= not B;
                add_cin <= '1';
            when others =>
                add_b   <= (others => '0');
                add_cin <= '0';
        end case;
    end process;

    --------------------------------------------------------------------
    -- Instantiate nBitAdder
    --------------------------------------------------------------------
    Adder_Unit: nBitAdder
        generic map (N => N)
        port map (
            A    => A,
            B    => add_b,
            Cin  => add_cin,
            Sum  => add_sum,
            Cout => add_cout
        );

    --------------------------------------------------------------------
    -- Main ALU Logic
    --------------------------------------------------------------------
    process(ALUctr, A, B, add_sum, add_cout)
    begin
        case ALUctr is
            when "000" =>  -- ADD
                alu_result <= add_sum;
                Carryout   <= add_cout;

            when "001" =>  -- SUB
                alu_result <= add_sum;
                Carryout   <= add_cout;

            when "010" =>  -- AND
                alu_result <= A and B;
                Carryout   <= '0';

            when "011" =>  -- OR
                alu_result <= A or B;
                Carryout   <= '0';

            when "100" =>  -- Logical Left Shift
                alu_result <= shift_left(A, 1);
                Carryout   <= A(N-1);

            when "101" =>  -- Logical Right Shift
                alu_result <= shift_right(A, 1);
                Carryout   <= A(0);

            when "110" =>  -- Arithmetic Left Shift
                alu_result <= shift_left(A, 1);
                Carryout   <= A(N-1);

            when "111" =>  -- Arithmetic Right Shift
                alu_result <= (A(N-1) & A(N-1 downto 1));
                Carryout   <= A(0);

            when others =>
                alu_result <= (others => '0');
                Carryout   <= '0';
        end case;
    end process;

    --------------------------------------------------------------------
    -- Overflow & Zero Detection
    --------------------------------------------------------------------
    sign_a <= A(N-1);
    sign_b <= (B(N-1) xor ALUctr(0)); -- flip sign input during SUB
    sign_r <= alu_result(N-1);

    Overflow <= (sign_a and sign_b and not sign_r) or
                (not sign_a and not sign_b and sign_r);

    Result <= alu_result;

    Zero <= '1' when alu_result = (others => '0') else '0';

end Behavioral;
