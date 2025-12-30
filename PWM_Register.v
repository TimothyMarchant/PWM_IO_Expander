/*
PWM 
Allows one output to have a selectable duty cycle and fixed frequency (frequency choosable from a few options).
Frequency options 50hz, 120hz, 200hz, 400hz, 1000hz, 2000hz, and 4000hz.


*/


module PWMRegister # (parameter StartAddress=0, parameter AddressWidth=8) 
(input CLK,input _Write,input [AddressWidth-1:0] AddressBus, input [7:0] DataIn, input _RST, output PWMOut);
//declarations
wire [15:0] SwitchValue;
wire [15:0] CountOutputs;
wire [15:0] PrescalerOutputs;
//Clock clocks data in on posedge.
wire RegisterCLK;
assign RegisterCLK=~_Write;

//module instanations.



AddressableRegister # (.AddressValue(StartAddress+0)) SwitchValueUpper  (.CLK(RegisterCLK),._HOLD('b0),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(SwitchValue[15:8]));

AddressableRegister # (.AddressValue(StartAddress+1)) SwitchValueLower (.CLK(RegisterCLK),._HOLD('b0),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(SwitchValue[7:0]));

AddressableRegister # (.AddressValue(StartAddress+2)) TimerCountUpper (.CLK(RegisterCLK),._HOLD('b0),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(CountOutputs[15:8]));

AddressableRegister # (.AddressValue(StartAddress+3)) TimerCountLower (.CLK(RegisterCLK),._HOLD('b0),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(CountOutputs[7:0]));

AddressableRegister # (.AddressValue(StartAddress+4)) TimerPrescalerUpper (.CLK(RegisterCLK),._HOLD('b0),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(PrescalerOutputs[15:8]));

AddressableRegister # (.AddressValue(StartAddress+5)) TimerPrescalerLower (.CLK(RegisterCLK),._HOLD('b0),._RST(_RST),.AddressBus(AddressBus),
.DataIn(DataIn),.DataOut(PrescalerOutputs[7:0]));

Timer PWMTimer (.CLK(CLK),._RST(_RST),.Prescaler(PrescalerOutputs),.Count(CountOutputs),.SwitchValue(SwitchValue),.TimerOut(PWMOut));



endmodule