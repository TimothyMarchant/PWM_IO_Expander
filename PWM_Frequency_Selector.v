//more so determine how long it takes to reach the highest necessary value.
//Need a prescaler and timer value that resets the timer.  The only frequency that we want extremely close to is 50Hz.
//default frequency is 4000hz.
//Frequency options 50hz, 120hz, 200hz, 400hz, 1000hz, 2000hz, and 4000hz.

module PWMFrequencySelector # (parameter Frequency=50000000) (input CLK, input [15:0] TimerSwitchCount,input _RST, input [7:0] Select, output OutputPWM);



always @(posedge CLK) begin

end


endmodule