library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit is
    port (
        instr     : in  unsigned(3 downto 0);
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

begin

    process(instr)
    begin
        RegDst   <= '0';
        ALUSrc   <= '0';
        MemToReg <= '0';
        RegWrite <= '0';
        MemRead  <= '0';
        MemWrite <= '0';
        Branch   <= '0';
        Jump     <= '0';
        ALUOp    <= "1111"; ---1111 for no alu op

        case instr is

            -- R-type
            when "0000" =>
                MemToReg <= '1';
                RegDst   <= '1';
                RegWrite <= '1';
                ALUOp    <= "0000";  -- R-type: defer to func bits
            when "0001" =>
                MemToReg <= '1';
                RegDst   <= '1';
                RegWrite <= '1';
                ALUOp    <= "0001";  -- R-type: defer to func bits

            -- I-type arithmetic
            when "0010" =>  -- ADDI
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                ALUOp    <= "0010";  -- add

            when "0011" =>  -- SUBI
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                ALUOp    <= "0011";  -- sub
            when "0100" =>  -- MulI
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                ALUOp    <= "0100";  -- mul

            when "0101" =>  -- DivI
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                ALUOp    <= "0101";  -- div

            when "0110" =>  -- ANDI
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                ALUOp    <= "0110";  -- and

            when "0111" =>  -- ORI
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                ALUOp    <= "0111";  -- or

            when "1000" =>  -- LW
                ALUSrc   <= '1';
                RegWrite <= '1';
                MemRead  <= '1';
                ALUOp    <= "0000";  -- add for address calc

            when "1001" =>  -- SW
                ALUSrc   <= '1';
                MemWrite <= '1';
                ALUOp    <= "0000";  -- add for address calc

            when "1010" =>  -- BEQ
                Branch   <= '1';
                ALUOp    <= "0001";  -- sub for equality check
                
            when "1011" =>  -- BEQlt
                Branch   <= '1';
                ALUOp    <= "0001";  -- sub for equality check
                
            when "1100" =>  -- BEQgt
                Branch   <= '1';
                ALUOp    <= "0001";  -- sub for equality check

            when "1101" =>  -- JUMP
                Jump <= '1';
                
            when "1110" =>  -- Shift Left Logical Immediate
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                ALUOp    <= "1000";

            when "1111" =>  -- Shift Right Logical Immediate
                ALUSrc   <= '1';
                MemToReg <= '1';
                RegWrite <= '1';
                ALUOp    <= "1001";

            when others =>
                null;
        end case;
    end process;
end architecture Behavioral;
