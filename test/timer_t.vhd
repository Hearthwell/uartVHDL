library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Timer_t is
end Timer_t;

architecture Behavioral of Timer_t is
    constant DELAY: time := 10 ns;
    constant period: integer := 4;

    signal clk:   std_logic := '0';
    signal start: std_logic := '0';
    signal int:   std_logic;

begin
    timer: entity work.Timer(Behavioral) generic map(period) port map(clk, start, int);

    process is
    begin
        clk <= not(clk);
        wait for 1 ns;
    end process;

    process is
    begin
        start <= '1';
        wait for 1 ns;
        start <= '0';
        wait for 2 * DELAY;

        assert 1 = 0 report "ALL TEST PASSED" severity failure;
    end process;

end Behavioral;