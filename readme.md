# VHDL UART Transmitter (FOR FPGA)

# The receiving part is coming soon!

The uart_client periodicaly send the same bytes at a specific interval (Can be adapted to send strings instead of the periodic same bytes)

## My current testing setup is to run the module on an FPGA and connect the gpio pins used for the uart tx to an TTY to USB Adapter. We can then read the values by reading the serial input of the Adapter.

### The Module assumes a clock rate of 125MHz and a baudrate of 9600
### For this config you would set the generic module values to (tim_dly = 125000000 and uart_period = 13021). The top Level module would be src/uart_client.vhd

#### To change the baudrate of your tty -> USB device you can use the command:
```
stty -F /dev/ttyUSB0 9600
```

#### To Read
```
screen /dev/ttyUSB0 9600
```

### You Should get an output Similar to:
```
1234567890123456789...
```
### Because we are continously sending the value 0b00110011 which translates to the character '3' every second 

# Running The simulation

## Running the bare Uart sim
```
make uart
gtkwave output
```

## Running the bare Timer sim
```
make timer
gtkwave output
```

## Running the Uart client sim (periodically send the char '3' every second)
```
make uart_client
gtkwave output.ghw
```

## Use In an FPGA projects
### Import the src dir to your vivado project
### Add Constraint file for mapping the clk and tx ports to the board
### Generate Bitstream and program FPGA
### You can now connect your mapped tx port to the rx pin of the tty -> USB adapter
### And connect the ground pin of the adapter to any ground point on your board