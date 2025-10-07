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
    generic ( N : integer := 32 );
    Port (
        A, B     : in  STD_LOGIC_VECTOR(N-1 downto 0);
        ALUctr   : in  STD_LOGIC_VECTOR(2 downto 0);
        Result   : out STD_LOGIC_VECTOR(N-1 downto 0);
        Zero, Overflow, Carryout : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is

    --------------------------------------------------------------------
    -- Component Declaration
    --------------------------------------------------------------------
    component nBitAdder
        generic ( N : integer := 32 );
        port (
            A, B  : in  STD_LOGIC_VECTOR(N-1 downto 0);
            Cin   : in  STD_LOGIC;
            Sum   : out STD_LOGIC_VECTOR(N-1 downto 0);
            Cout  : out STD_LOGIC
        );
    end component;

    --------------------------------------------------------------------
    -- Internal Signals
    --------------------------------------------------------------------
    signal add_b, add_sum, alu_result : STD_LOGIC_VECTOR(N-1 downto 0);
    signal add_cout, add_cin : STD_LOGIC;
    signal sign_a, sign_b, sign_r : STD_LOGIC;

begin
    --------------------------------------------------------------------
    -- Configure adder inputs based on ALU control
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
    -- Instantiate 32-bit Ripple-Carry Adder
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

        when "100" =>  -- Logical Left Shift (by 1 bit)
            alu_result <= std_logic_vector(shift_left(unsigned(A), 1));
            Carryout   <= A(N-1);

        when "101" =>  -- Logical Right Shift (by 1 bit)
            alu_result <= std_logic_vector(shift_right(unsigned(A), 1));
            Carryout   <= A(0);

        when "110" =>  -- Arithmetic Left Shift (same as logical left)
            alu_result <= std_logic_vector(shift_left(unsigned(A), 1));
            Carryout   <= A(N-1);

        when "111" =>  -- Arithmetic Right Shift (preserve sign)
            alu_result <= std_logic_vector(shift_right(signed(A), 1));
            Carryout   <= A(0);

        when others =>
            alu_result <= (others => '0');
            Carryout   <= '0';
    end case;
end process;

    --------------------------------------------------------------------
    -- Overflow Detection
    --------------------------------------------------------------------
    sign_a <= A(N-1);
    sign_b <= B(N-1);
    sign_r <= alu_result(N-1);

    process(ALUctr, sign_a, sign_b, sign_r)
    begin
        if ALUctr = "000" then  -- ADD
            Overflow <= (sign_a and sign_b and not sign_r) or
                        (not sign_a and not sign_b and sign_r);
        elsif ALUctr = "001" then  -- SUB
            Overflow <= (sign_a and not sign_b and not sign_r) or
                        (not sign_a and sign_b and sign_r);
        else
            Overflow <= '0';
        end if;
    end process;
    --------------------------------------------------------------------
-- Zero flag detection
--------------------------------------------------------------------
process(alu_result)
begin
    if alu_result = B"0000_0000_0000_0000_0000_0000_0000_0000" then
        Zero <= '1';
    else
        Zero <= '0';
    end if;
end process;

    --------------------------------------------------------------------
    -- Final Output Assignments
    --------------------------------------------------------------------
    Result <= alu_result;

end Behavioral;