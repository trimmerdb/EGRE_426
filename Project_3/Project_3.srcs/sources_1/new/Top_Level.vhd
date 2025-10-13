library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_Level is
    Port (
        clk       : in  STD_LOGIC;
        RegWr     : in  STD_LOGIC;
        Rd, Rs, Rt : in  unsigned(4 downto 0);
        ALUctr    : in  unsigned(3 downto 0);
        Zero, Overflow, Carryout : out STD_LOGIC;
        Result    : out unsigned(31 downto 0)
    );
end Top_Level;

architecture Behavioral of Top_Level is

    signal busA, busB, busW : unsigned(31 downto 0); -- Internal buses

    component Registers -- Component: Registers
        Port (
            clk    : in  STD_LOGIC;
            RegWr  : in  STD_LOGIC;
            Ra, Rb, Rw : in  unsigned(4 downto 0);
            busW   : in  unsigned(31 downto 0);
            busA, busB : out unsigned(31 downto 0)
        );
    end component;

    component ALU -- Component: ALU
        generic ( N : integer := 32 );
        Port (
            A, B    : in  unsigned(31 downto 0);
            ALUctr  : in  unsigned(3 downto 0);
            Result  : out unsigned(31 downto 0);
            Zero, Overflow, Carryout : out STD_LOGIC
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
        generic map ( N => 32 )
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
