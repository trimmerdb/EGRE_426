library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Top_Level_tb is
end entity;

architecture Behavioral of Top_Level_tb is
  constant TIME_DELAY : time := 20 ns;

  signal clk_sig    : std_logic := '0';
  signal reset_sig  : std_logic := '0';
  signal RegWr_sig  : std_logic := '0'; 
  signal Rd_sig, Rs_sig, Rt_sig : unsigned(2 downto 0) := (others => '0');
  signal ALUctr_sig : unsigned(3 downto 0) := (others => '0');
  signal Result_sig : unsigned(15 downto 0);

begin
  --------------------------------------------------------------------
  -- DUT
  --------------------------------------------------------------------
  DUT : entity work.Top_Level(Behavioral)
    port map (
      clk    => clk_sig,
      Reset  => reset_sig,
      RegWr  => RegWr_sig,
      Rd     => Rd_sig,
      Rs     => Rs_sig,
      Rt     => Rt_sig,
      ALUctr => ALUctr_sig,
      Result => Result_sig
    );

  --------------------------------------------------------------------
  -- CLOCK GENERATION (kept same style)
  --------------------------------------------------------------------
  clock : process
  begin
    while true loop
      clk_sig <= not clk_sig;
      wait for TIME_DELAY / 2;
    end loop;
  end process clock;

  --------------------------------------------------------------------
  -- STIMULUS PROCESS
  --------------------------------------------------------------------
  stimulus : process
  begin
    -- Initial reset
    reset_sig <= '1';
    wait for TIME_DELAY;
    reset_sig <= '0';

    for i in 0 to 150 loop
      wait for TIME_DELAY;
    end loop;

    wait;
  end process stimulus;

  --------------------------------------------------------------------
  -- MONITOR PROCESS
  --------------------------------------------------------------------
--  monitor : process
--  begin
--    wait for TIME_DELAY / 2;
--    while true loop
--      wait for TIME_DELAY;
--    end loop;
--  end process monitor;

end Behavioral;
