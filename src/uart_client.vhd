library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UartClient is
    generic(
        tim_dly:     integer;
        uart_period: integer);
    port (
        clk: in std_logic;
        tx : out std_logic); 
end UartClient;

architecture Behavioral of UartClient is
    constant LOWER_BOUND : INTEGER := 48;
    constant UPPER_BOUND : INTEGER := 57;

    signal tim_start: std_logic := '0'; 
    signal tim_done:  std_logic := '0';

    signal uart_start: std_logic := '0';
    signal uart_data : std_logic_vector(7 downto 0) := (others => '0');
    signal busy      : std_logic := '0'; -- NOT USED FOR NOW BECAUSE THE TIME DELAY IS KNOWN TO BE HIGHER THAN THE TIME NEEDED FOR ONE BYTE UART TRANSFER 

    signal reset     : std_logic := '1';

    signal counter : UNSIGNED(7 downto 0) := TO_UNSIGNED(LOWER_BOUND, 8);

begin
timer: entity work.Timer(Behavioral) generic map(tim_dly) port map(clk, tim_start, tim_done);
uart : entity work.Uart(RTL) generic map(uart_period) port map(clk, uart_start, uart_data, busy, tx);

    process(clk) is
    begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                tim_start <= '1';
                reset <= '0';
            elsif(tim_done = '1') then
                
                if(counter = TO_UNSIGNED(UPPER_BOUND, counter'LENGTH)) then
                    counter <= TO_UNSIGNED(LOWER_BOUND, 8);
                else
                    counter <= counter + 1;
                end if;

                uart_start <= '1';
                tim_start <= '1';
            else 
                uart_start <= '0';
                tim_start <= '0';
            end if;
        end if;
    end process;

    uart_data <= STD_LOGIC_VECTOR(counter);

end Behavioral ; -- Behavioral