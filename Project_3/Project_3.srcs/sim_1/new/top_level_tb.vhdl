library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Top_Level_tb is
end entity;

architecture behavior of Top_Level_tb is
    constant TIME_DELAY : time := 20 ns;

    -- DUT signals
    signal clk_sig     : std_logic := '0';
    signal reset_sig   : std_logic := '0';
    signal RegWr_sig   : std_logic := '0';
    signal Rd_sig      : unsigned(2 downto 0) := (others => '0');
    signal Rs_sig      : unsigned(2 downto 0) := (others => '0');
    signal Rt_sig      : unsigned(2 downto 0) := (others => '0');
    signal ALUctr_sig  : unsigned(3 downto 0) := (others => '0');
    signal Result_sig  : unsigned(15 downto 0);

begin
    --------------------------------------------------------------------
    -- DUT instantiation
    --------------------------------------------------------------------
    DUT : entity work.Top_Level(Behavioral)
        port map(
            clk       => clk_sig,
            Reset     => reset_sig,
            RegWr     => RegWr_sig,
            Rd        => Rd_sig,
            Rs        => Rs_sig,
            Rt        => Rt_sig,
            ALUctr    => ALUctr_sig,
            Result    => Result_sig
        );

    --------------------------------------------------------------------
    -- Clock generation
    --------------------------------------------------------------------
    clock_proc : process
    begin
        while true loop
            clk_sig <= '0';
            wait for TIME_DELAY / 2;
            clk_sig <= '1';
            wait for TIME_DELAY / 2;
        end loop;
    end process clock_proc;

    --------------------------------------------------------------------
    -- Stimulus generation
    --------------------------------------------------------------------
    stimulus_proc : process
    begin
        -- Reset
        reset_sig <= '1';
        wait for TIME_DELAY;
        reset_sig <= '0';

        -- Basic initialization
        RegWr_sig <= '0';
        Rs_sig    <= (others => '0');
        Rt_sig    <= (others => '0');
        Rd_sig    <= (others => '0');
        ALUctr_sig <= "0000";  -- default ADD
        wait for TIME_DELAY;

        ----------------------------------------------------------------
        -- Test: ADD
        ----------------------------------------------------------------
        report "Testing ADD operation";
        RegWr_sig <= '1';
        Rs_sig <= "000"; 
        Rt_sig <= "001";
        Rd_sig <= "010";
        ALUctr_sig <= "0000";  -- ADD
        wait for TIME_DELAY;

        ----------------------------------------------------------------
        -- Test: SUB
        ----------------------------------------------------------------
        report "Testing SUB operation";
        RegWr_sig <= '1';
        Rs_sig <= "001"; 
        Rt_sig <= "010";
        Rd_sig <= "011";
        ALUctr_sig <= "0001";  -- SUB
        wait for TIME_DELAY;

        ----------------------------------------------------------------
        -- Test: AND
        ----------------------------------------------------------------
        report "Testing AND operation";
        RegWr_sig <= '1';
        Rs_sig <= "010"; 
        Rt_sig <= "011";
        Rd_sig <= "100";
        ALUctr_sig <= "0010";  -- AND
        wait for TIME_DELAY;

        ----------------------------------------------------------------
        -- Test: OR
        ----------------------------------------------------------------
        report "Testing OR operation";
        RegWr_sig <= '1';
        Rs_sig <= "011"; 
        Rt_sig <= "100";
        Rd_sig <= "101";
        ALUctr_sig <= "0011";  -- OR
        wait for TIME_DELAY;

        ----------------------------------------------------------------
        -- Test: SLL (Logical Left Shift)
        ----------------------------------------------------------------
        report "Testing SLL operation";
        RegWr_sig <= '1';
        Rs_sig <= "100"; 
        Rt_sig <= "101";
        Rd_sig <= "110";
        ALUctr_sig <= "0100";  -- Shift Left
        wait for TIME_DELAY;

        ----------------------------------------------------------------
        -- Test: SRL (Logical Right Shift)
        ----------------------------------------------------------------
        report "Testing SRL operation";
        RegWr_sig <= '1';
        Rs_sig <= "101"; 
        Rt_sig <= "110";
        Rd_sig <= "111";
        ALUctr_sig <= "0101";  -- Shift Right
        wait for TIME_DELAY;

        ----------------------------------------------------------------
        -- Finish Simulation
        ----------------------------------------------------------------
        RegWr_sig <= '0';
        wait for 5 * TIME_DELAY;
        assert false report "Simulation Complete." severity note;
        wait;
    end process stimulus_proc;

    --------------------------------------------------------------------
    -- Monitor process
    --------------------------------------------------------------------
    monitor_proc : process
    begin
        wait on Result_sig;
        report "Time=" & integer'image(integer(now / 1 ns)) &
               " ns | Result=" & integer'image(to_integer(Result_sig));
    end process monitor_proc;

end architecture behavior;
