library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ControlUnit_TB is
end ControlUnit_TB;

architecture Behavioral of ControlUnit_TB is
    constant TIME_DELAY : time := 20 ns;

    signal clk_sig : std_logic := '0';
    signal instrSig : unsigned(3 downto 0) := X"0";
    signal regDstSig : std_logic := '0';
    signal ALUSrcSig : std_logic := '0';
    signal memToRegSig : std_logic := '0';
    signal regWriteSig : std_logic := '0';
    signal memReadSig : std_logic := '0';
    signal memWriteSig : std_logic := '0';
    signal brancheqSig : std_logic := '0';
    signal branchgtSig : std_logic := '0';
    signal branchltSig : std_logic := '0';
    signal jumpSig : std_logic := '0';
    signal ALUOpSig : unsigned(3 downto 0) := X"0";

begin
    stimulus : process
    begin
        loop
            wait for 10 ns;
            instrSig <= instrSig+1;
            if instrSig = X"E" then
                wait;
            end if;
        end loop;
    end process stimulus;
    
    dut : entity work.ControlUnit(Behavioral)
        port map(
            instr => instrSig,
            RegDst => regDstSig,
            ALUSrc => ALUSrcSig,
            MemToReg => memToRegSig,
            RegWrite => regWriteSig,
            MemRead => memReadSig,
            MemWrite => memWriteSig,
            BranchEQ => brancheqSig,
            BranchGT => branchgtSig,
            BranchLT => branchltSig,
            Jump => jumpSig,
            ALUOp => ALUOpSig
        );
end Behavioral;