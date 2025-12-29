/*
PWM 
Allows one output to have a selectable duty cycle and fixed frequency (frequency choosable from a few options).
Frequency options 50hz, 120hz, 200hz, 400hz, 1000hz, 2000hz, and 4000hz.


*/


module PWMRegister # (parameter StartAddress=0, parameter AddressWidth=8, parameter BitWidth=8, parameter Frequency=50000000) 
(input CLK,input _Write,input [AddressWidth-1:0] AddressBus, input [BitWidth-1:0] DataIn, input _HOLD, input _RST, output PWMOut);
//declarations
wire [15:0] SwitchValue;
wire [15:0] CountOutputs;
wire [15:0] PrescalerOutputs;


//module instanations.



AddressableRegister # (.AddressValue(StartAddress+0)) SwitchValueUpper  (.CLK(_Write),._HOLD(_HOLD),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(SwitchValue[15:8]));

AddressableRegister # (.AddressValue(StartAddress+1)) SwitchValueLower (.CLK(_Write),._HOLD(_HOLD),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(SwitchValue[7:0]));

AddressableRegister # (.AddressValue(StartAddress+2)) TimerCountUpper (.CLK(_Write),._HOLD(_HOLD),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(CountOutputs[15:8]));

AddressableRegister # (.AddressValue(StartAddress+3)) TimerCountLower (.CLK(_Write),._HOLD(_HOLD),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(CountOutputs[7:0]));

AddressableRegister # (.AddressValue(StartAddress+4)) TimerPrescalerUpper (.CLK(_Write),._HOLD(_HOLD),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(PrescalerOutputs[15:8]));

AddressableRegister # (.AddressValue(StartAddress+5)) TimerPrescalerLower (.CLK(_Write),._HOLD(_HOLD),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(PrescalerOutputs[7:0]));

Timer PWMTimer (.CLK(CLK),._RST(_RST),.Prescaler(PrescalerOutputs),.Count(CountOutputs),.SwitchValue(SwitchValue),.TimerOut(PWMOut));



endmodule