----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2025 02:37:10 PM
-- Design Name: 
-- Module Name: ControlUnit_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit_TB is
--  Port ( );
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
