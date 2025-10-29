library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit is
    port (
        instr     : in  unsigned(15 downto 0);
        RegDst    : out std_logic;
        ALUSrc    : out std_logic;
        MemToReg  : out std_logic;
        RegWrite  : out std_logic;
        MemRead   : out std_logic;
        MemWrite  : out std_logic;
        Branch    : out std_logic;
        Jump      : out std_logic;
        ALUOp     : out unsigned(3 downto 0)
    );
end entity ControlUnit;

architecture Behavioral of ControlUnit is
    signal opcode : unsigned(3 downto 0);
    signal func   : unsigned(2 downto 0);
begin
    opcode <= instr(15 downto 12);
    func   <= instr(2 downto 0);

    process(opcode, func)
    begin
        RegDst   <= '0';
        ALUSrc   <= '0';
        MemToReg <= '0';
        RegWrite <= '0';
        MemRead  <= '0';
        MemWrite <= '0';
        Branch   <= '0';
        Jump     <= '0';
        ALUOp    <= "0000";

        case opcode is

            -- R-TYPE INSTRUCTIONS
            when "0000" =>
                RegDst   <= '1';
                ALUSrc   <= '0';
                RegWrite <= '1';
                case func is
                    when "000" => ALUOp <= "0000"; -- add
                    when "001" => ALUOp <= "0001"; -- sub
                    when "010" => ALUOp <= "0010"; -- mul
                    when "011" => ALUOp <= "0011"; -- div
                    when "100" => ALUOp <= "0100"; -- and
                    when "101" => ALUOp <= "0101"; -- or
                    when "110" => ALUOp <= "0110"; -- xor
                    when "111" => ALUOp <= "1111"; -- halt
                    when others => ALUOp <= "0000";
                end case;
            when "0001" =>
                RegDst   <= '1';
                ALUSrc   <= '0';
                RegWrite <= '1';
                case func is
                    when "000" => ALUOp <= "0000"; -- sll
                    when "001" => ALUOp <= "0001"; -- srl
                    when "010" => ALUOp <= "0010"; -- sla
                    when "011" => ALUOp <= "0011"; -- sra
                    when "100" => ALUOp <= "0100"; -- nor
                    when "101" => ALUOp <= "0101"; -- nand
                    when "110" => ALUOp <= "0110"; -- xnor
                    when others => ALUOp <= "0000";
                end case;

            -- I-TYPE INSTRUCTIONS
            when "0010" =>  -- addi
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "0000";

            when "0011" =>  -- subi
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "0001";

            when "0100" =>  -- muli
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "0010";

            when "0101" =>  -- divi
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "0011";

            when "0110" =>  -- andi
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "0100";

            when "0111" =>  -- ori
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "0101";

            when "1000" =>  -- lw
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                MemRead  <= '1';
                ALUOp    <= "0000";  -- use add for address calc maybe?

            when "1001" =>  -- sw
                ALUSrc   <= '1';
                MemWrite <= '1';
                ALUOp    <= "0000";  -- use add for address calc maybe?

            when "1010" =>  -- beq
                Branch   <= '1';
                ALUOp    <= "1000";  -- equality compare

            when "1011" =>  -- blt
                Branch   <= '1';
                ALUOp    <= "1001";  -- less than

            when "1100" =>  -- bgt
                Branch   <= '1';
                ALUOp    <= "1010";  -- greater than

            when "1101" =>  -- jump
                Jump     <= '1';

            when "1110" =>  -- slli
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "0111";

            when "1111" =>  -- srli
                ALUSrc   <= '1';
                RegWrite <= '1';
                ALUOp    <= "1000";

            when others =>
                null;
        end case;
    end process;
end architecture Behavioral;
