library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALUControl is
    port (
        ALUOp  : in  unsigned(3 downto 0);
        func   : in  unsigned(2 downto 0);
        ALUctr : out unsigned(3 downto 0)
    );
end entity ALUControl;

architecture Behavioral of ALUControl is
begin
    process(ALUOp, func)
    begin
        case ALUOp is

            -- R-type: decode func bits
            when "0000" =>
                case func is
                    when "000" => ALUctr <= "0000"; -- Add
                    when "001" => ALUctr <= "0001"; -- Sub
                    when "010" => ALUctr <= "1000"; -- Mul
                    when "011" => ALUctr <= "1001"; -- Div
                    when "100" => ALUctr <= "0010"; -- AND
                    when "101" => ALUctr <= "0011"; -- OR
                    when "110" => ALUctr <= "1010"; -- XOR
                    when others => ALUctr <= "0000";
                end case;
                        -- R-type: decode func bits
            when "0001" =>
                case func is
                    when "000" => ALUctr <= "0100"; -- SLL
                    when "001" => ALUctr <= "0101"; -- SRL
                    when "010" => ALUctr <= "0110"; -- SLA
                    when "011" => ALUctr <= "0111"; -- SRA
                    when "100" => ALUctr <= "1011"; -- NOR
                    when "101" => ALUctr <= "1100"; -- NAND
                    when "110" => ALUctr <= "1101"; -- XNOR
                    when "111" => ALUctr <= "1110"; -- HALUT
                    when others => ALUctr <= "0000";
                end case;
            -- Direct ALU operations (I-type)
            when "0010" => ALUctr <= "0000"; -- Add
            when "0011" => ALUctr <= "0001"; -- Sub
            when "0100" => ALUctr <= "1000"; -- Mul
            when "0101" => ALUctr <= "1001"; -- Div
            when "0110" => ALUctr <= "0010"; -- AND
            when "0111" => ALUctr <= "0011"; -- OR
            when "1000" => ALUctr <= "0100"; -- SLL
            when "1001" => ALUctr <= "0101"; -- SRL
            when others =>
                ALUctr <= "0000";
        end case;
    end process;
end architecture Behavioral;
