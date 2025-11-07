library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    generic ( N : integer := 16 );
    Port (
        A, B     : in  unsigned(N-1 downto 0);
        ALUctr   : in  unsigned(3 downto 0);
        Result   : out unsigned(N-1 downto 0);
        Zero, Overflow, Carryout : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is

    component nBitAdder
        generic ( N : integer := 16 );
        port (
            A, B  : in  unsigned(N-1 downto 0);
            Cin   : in  STD_LOGIC;
            Sum   : out unsigned(N-1 downto 0);
            Cout  : out STD_LOGIC
        );
    end component;

    -- Internal Signals
    signal add_b, add_sum, alu_result : unsigned(N-1 downto 0);
    signal add_cout, add_cin : STD_LOGIC;
    signal sign_a, sign_b, sign_r : STD_LOGIC;
begin

    -- Select inputs for adder depending on ALUctr
    process(ALUctr, A, B)
    begin
        case ALUctr is
            when "0000" =>  -- ADD
                add_b   <= B;
                add_cin <= '0';
            when "0001" =>  -- SUB
                add_b   <= not B;
                add_cin <= '1';
            when others =>
                add_b   <= (others => '0');
                add_cin <= '0';
        end case;
    end process;

    -- Instantiate n-bit adder
    Adder_Unit: nBitAdder
        generic map (N => N)
        port map (
            A    => A,
            B    => add_b,
            Cin  => add_cin,
            Sum  => add_sum,
            Cout => add_cout
        );

    -- Main ALU Logic
    process(ALUctr, A, B, add_sum, add_cout)
        variable temp_product : unsigned((2*N)-1 downto 0);
        variable dividend   : unsigned(N-1 downto 0);
        variable divisor    : unsigned(N-1 downto 0);
        variable quotient   : unsigned(N-1 downto 0);
        variable remainder  : unsigned(N downto 0);
        variable temp       : unsigned(N downto 0);
        variable i : integer;
    begin
        alu_result <= (others => '0');
        Carryout   <= '0';
        Overflow   <= '0';

        case ALUctr is
            when "0000" =>  -- ADD
                alu_result <= add_sum;
                Carryout   <= add_cout;

            when "0001" =>  -- SUB
                alu_result <= add_sum;
                Carryout   <= not add_cout;

            when "0010" =>  -- AND
                alu_result <= A and B;
                Carryout   <= '0';

            when "0011" =>  -- OR
                alu_result <= A or B;
                Carryout   <= '0';

            when "0100" =>  -- Logical Left Shift
                alu_result <= shift_left(A, 1);
                Carryout   <= '0';

            when "0101" =>  -- Logical Right Shift
                alu_result <= shift_right(A, 1);
                Carryout   <= '0';

            when "0110" =>  -- Arithmetic Left Shift
                alu_result <= shift_left(A, 1);
                Carryout   <= '0';

            when "0111" =>  -- Arithmetic Right Shift
                alu_result <= shift_right(A, 1);
                alu_result(N-1) <= A(N-1);  -- preserve sign
                Carryout   <= '0';

            when "1000" =>  -- MULTIPLICATION
                temp_product := (others => '0');
                temp_product(N-1 downto 0) := B;     -- lower bits = multiplier

                for i in 0 to N-1 loop
                    if temp_product(0) = '1' then
                        temp_product((2*N)-1 downto N) :=
                            temp_product((2*N)-1 downto N) + A;
                    end if;
                    -- logical right shift
                    temp_product := '0' & temp_product((2*N)-1 downto 1);
                end loop;

                alu_result <= temp_product(N-1 downto 0);
                Carryout   <= temp_product(N);  -- upper bit carry indicator
                
             when "1001" =>  -- DIVISION
                if B = 0 then
                    alu_result <= (others => '0');  -- divide by zero
                    Carryout   <= '0';
                else
                    dividend  := A;
                    divisor   := B;
                    remainder := (others => '0');
                    quotient  := (others => '0');

                    for i in N-1 downto 0 loop
                        -- Shift left remainder and bring down next dividend bit
                        remainder := shift_left(remainder, 1);
                        remainder(0) := dividend(i);
            
                        -- Try subtraction
                        temp := remainder - ("0" & divisor);  -- extend divisor by 1 bit
            
                        if temp(N) = '0' then  -- no borrow => remainder >= divisor
                            remainder := temp;
                            quotient(i) := '1';
                        else
                            null;
                        end if;
                    end loop;
            
                    alu_result <= quotient;  -- output quotient
                    Carryout   <= '0';
                    Overflow   <= '0';
                end if;
            when "1010" =>  -- XOR
                alu_result <= A xor B;
                Carryout   <= '0';
            when "1011" =>  -- NOR
                alu_result <= A xor B;
                Carryout   <= '0';
            when "1100" =>  -- NAND
                alu_result <= A xor B;
                Carryout   <= '0';
            when "1101" =>  -- XNOR
                alu_result <= A xor B;
                Carryout   <= '0';
            when "1110" =>  -- HAULT
                alu_result <= A xor B;
                Carryout   <= '0';
            when others =>
                alu_result <= (others => '0');
                Carryout   <= '0';
        end case;
    end process;

    -- Overflow Detection
    sign_a <= A(N-1);
    sign_b <= B(N-1);
    sign_r <= alu_result(N-1);

    process(ALUctr, sign_a, sign_b, sign_r)
    begin
        if ALUctr = "0000" then  -- ADD
            Overflow <= (sign_a and sign_b and not sign_r) or
                        (not sign_a and not sign_b and sign_r);
        elsif ALUctr = "0001" then  -- SUB
            Overflow <= (sign_a and not sign_b and not sign_r) or
                        (not sign_a and sign_b and sign_r);
        elsif (ALUctr = "1001" and B = 0) then
            Overflow <= '1';
        else
            Overflow <= '0';
        end if;
    end process;

    -- Zero flag
    process(alu_result)
    begin
        if alu_result = (B"0000_0000_0000_0000_0000_0000_0000_0000") then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;

    Result <= alu_result;

end Behavioral;
