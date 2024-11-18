library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UartClient_t is
end UartClient_t;

architecture Behavioral of UartClient_t is
    constant DELAY: time := 100 ns;
    constant TIMER_PERIOD: integer := 40;
    constant UART_PERIOD : integer := 2;

    signal clk: std_logic := '0';
    signal tx : std_logic;

begin
    uart_client: entity work.UartClient(Behavioral) generic map(TIMER_PERIOD, UART_PERIOD) port map(clk, tx);

    process is
    begin
        clk <= not(clk);
        wait for 1 ns;
    end process;

    process is
    begin
        wait for 4 * DELAY;

        assert 1 = 0 report "ALL TEST PASSED" severity failure;
    end process;

end Behavioral;