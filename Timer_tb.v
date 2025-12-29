//test timer
module Timer_tb();

reg CLK;
reg _RST;
reg [15:0] Prescaler;
reg [15:0] Count;
reg [15:0] SwitchValue;
wire TimerOutput;

Timer test(.CLK(CLK),._RST(_RST),.Prescaler(Prescaler),.Count(Count),.SwitchValue(SwitchValue),.TimerOut(TimerOutput));


initial begin
    $Monitor(TimerOutput);
    $dumpfile("Timer.vcd");
    $dumpvars(0,Timer_tb);
    //reset
    _RST<=0;
    Prescaler<=8;
    Count<=800;
    SwitchValue<=400;
    //Monitor Output
end


initial begin
always @ #5 begin
    CLK<=~CLK;
end
end

endmodule