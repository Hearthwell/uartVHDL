OUTPUT := output

uart: src/uart.vhd test/uart_t.vhd
	ghdl -a $^
	ghdl -r Uart_t --vcd=$(OUTPUT)

timer: src/timer.vhd test/timer_t.vhd
	ghdl -a $^
	ghdl -r Timer_t --vcd=$(OUTPUT)

uart_client: src/uart.vhd src/timer.vhd src/uart_client.vhd test/uart_client_t.vhd
	ghdl -a $^
	ghdl -r UartClient_t --wave=$(OUTPUT).ghw

clean:
	rm -f output *.cf *.ghw