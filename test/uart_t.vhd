library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Uart_t is
end Uart_t;

architecture Behavioral of Uart_t is
    constant PERIOD: time := 10 ns;
    constant UART_PERIOD: integer := 2;

    signal clk:    std_logic := '0';
    signal tx_rdy: std_logic := '0';
    signal data:   std_logic_vector(7 downto 0) := (others => '0');
    signal busy:   std_logic := '0';
    signal tx:     std_logic := '0';

begin
    uart: entity work.Uart(RTL) generic map(UART_PERIOD) port map(clk, tx_rdy, data, busy, tx);

    process is 
    begin
        clk <= not(clk);
        wait for 1 ns;
    end process;

    process is
    begin
        wait for PERIOD;
        data <= "00110011";
        tx_rdy <= '1';
        wait for 2 ns;
        tx_rdy <= '0';
        wait for PERIOD;
        
        wait for 4 * PERIOD;
        assert 1 = 0 report "ALL TEST PASSED" severity failure;
    end process;

end Behavioral;