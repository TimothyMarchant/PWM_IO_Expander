This project allows the user to configure an FPGA to have upto 42 PWM outputs (max address is 255).
Essentially it's just a bunch of configurable timers to allow for different overflows/prescalers.  Also you can set the duty cycle.
It is configured through SPI.  The first byte received is written to the address pointer and each subquental write goes to the register at the current pointer location
and then increments the address by 1.  Each PWM Register contains six 8-bit registers (upper/lower).  
The SPI Clock controls all logic.  The internal clock is meant for controlling the timer modules.  So there are no real problems with two different clock domains.  

I made this project to improve an older version of this where the PWM registers were not really that configurable (only a 8-bit duty cycle change; 4-bit address system). With this one you have control over the period and frequency. 
So if you really want you can control 42 servo motors.  It can also be expanded upon with more control logic.
This was used on the T8F81 FPGA from Efinix.  I only tested 4 GPIO because I didn't really feel like wiring up 42 LEDS (tested with bit banged SPI).  Also verified the hardware indepedent part in a testbench.  
It could be better, but I like it.
The biggest thing I learned from this is to make testbenches (some of which have been excluded).
