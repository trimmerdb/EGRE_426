library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_Level is
    Port (
        clk       : in  STD_LOGIC;
        RegWr     : in  STD_LOGIC;
        Rd, Rs, Rt : in  unsigned(2 downto 0);
        ALUctr    : in  unsigned(3 downto 0);
        Zero, Overflow, Carryout : out STD_LOGIC;
        Result    : out unsigned(15 downto 0)
    );
end Top_Level;

architecture Behavioral of Top_Level is

    signal busA, busB, busW : unsigned(15 downto 0); -- Internal buses

    component Registers -- Component: Registers
        Port (
            clk    : in  STD_LOGIC;
            RegWr  : in  STD_LOGIC;
            Ra, Rb, Rw : in  unsigned(2 downto 0);
            busW   : in  unsigned(15 downto 0);
            busA, busB : out unsigned(15 downto 0)
        );
    end component;

    component ALU -- Component: ALU
        generic ( N : integer := 16 );
        Port (
            A, B    : in  unsigned(N-1 downto 0);
            ALUctr  : in  unsigned(3 downto 0);
            Result  : out unsigned(N-1 downto 0);
            Zero, Overflow, Carryout : out STD_LOGIC
        );
    end component;
    
    component ProgramCounter -- Component: Program Counter
        generic ( N : integer := 16 );
        port (
            clk     : in  std_logic;
            rst     : in  std_logic;
            pc_in   : in  unsigned(N-1 downto 0);
            pc_out  : out unsigned(N-1 downto 0)
        );
    end component;
    
    component PCAdder -- Component: Program Adder
        generic ( N : integer := 16 );
            port (
        pc_in  : in  unsigned(N-1 downto 0);
        pc_out : out unsigned(N-1 downto 0)
    );
    end component;
    
    component InstructionMemory -- Component: Instruction Memory
        generic ( N : integer := 16 );
            port (
        clk   : in  std_logic;
        addr  : in  unsigned(N-1 downto 0);
        instr : out unsigned(N-1 downto 0)
    );
    end component;
    
    component SignExtend -- Component: Sign Extender
        generic ( N : integer := 16 );
            port (
        In16  : in  unsigned(5 downto 0);
        Out32 : out unsigned(N-1 downto 0)
    );
    end component;
    
    component MUX2to1 -- Component: MUX
        generic ( N : integer := 16 );
            port (
        A   : in  unsigned(N-1 downto 0);
        B   : in  unsigned(N-1 downto 0);
        Sel : in  std_logic;
        Y   : out unsigned(N-1 downto 0)
    );
    end component;
    
    component ShiftLeft2 -- Component: Left shift by 2
        generic ( N : integer := 16 );
            port (
        data_in  : in  unsigned(N-1 downto 0);
        data_out : out unsigned(N-1 downto 0)
    );
    end component;
    
    component DataMemory -- Component: Data Memory
        generic ( N : integer := 16 );
            port (
        clk      : in  std_logic;
        MemRead  : in  std_logic;
        MemWrite : in  std_logic;
        Address  : in  unsigned(N-1 downto 0);
        WriteData: in  unsigned(N-1 downto 0);
        ReadData : out unsigned(N-1 downto 0)
    );
    end component;

begin
    RF: Registers --My Register File
        port map (
            clk   => clk,
            RegWr => RegWr,
            Ra    => Rs,
            Rb    => Rt,
            Rw    => Rd,
            busW  => busW,
            busA  => busA,
            busB  => busB
        );

    ALU0: ALU --My Alu
        generic map ( N => 16 )
        port map (
            A        => busA,
            B        => busB,
            ALUctr   => ALUctr,
            Result   => busW,
            Zero     => Zero,
            Overflow => Overflow,
            Carryout => Carryout
        );

    Result <= busW; --Final Result

end Behavioral;
