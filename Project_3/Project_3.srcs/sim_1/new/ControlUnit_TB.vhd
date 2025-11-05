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
    signal branchSig : std_logic := '0';
    signal jumpSig : std_logic := '0';
    signal ALUOpSig : unsigned(3 downto 0) := X"0";

begin

--    clock_proc : process
--    begin
--        while true loop
--            clk_sig <= '0';
--            wait for TIME_DELAY / 2;
--            clk_sig <= '1';
--            wait for TIME_DELAY / 2;
--        end loop;
--    end process clock_proc;
    
    stimulus : process
    begin
        while(instrSig <= X"F") loop
            instrSig <= instrSig+1;
            wait for 10 ns;
        end loop;
    end process stimulus;
    
    dut : work.ControlUnit(Behavioral)
        port map(
            instr => instrSig,
            RegDst => regDstSig,
            ALUSrc => ALUSrcSig,
            MemToReg => memToRegSig,
            RegWrite => regWriteSig,
            MemRead => memReadSig,
            MemWrite => memWriteSig,
            Branch => branchSig,
            Jump => jumpSig,
            ALUOp => ALUOpSig
        );
end Behavioral;
