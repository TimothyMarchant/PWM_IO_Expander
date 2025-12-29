`timescale 1ns/1ns
//test timer
module Timer_tb();
localparam Countval=6000;
reg CLK;
reg _RST;
reg [15:0] Prescaler;
reg [15:0] Count;
reg [15:0] SwitchValue;
wire TimerOutput;
integer seed=2;
reg [15:0] val;
reg [15:0] val2;
Timer test(.CLK(CLK),._RST(_RST),.Prescaler(Prescaler),.Count(Count),.SwitchValue(SwitchValue),.TimerOut(TimerOutput));

initial begin
    CLK=0;
    #1
    forever begin
        #25 CLK=~CLK;
    end
end

initial begin
    
    $monitor(TimerOutput);
    $dumpfile("Timer.vcd");
    $dumpvars(0,Timer_tb);
    //reset
    _RST=0;
    #1
    Prescaler=15;
    Count=Countval;
    SwitchValue=Countval/4;    
    #1
    //Monitor Output
    _RST=1;
    $display("START");
    //Wait some time then cahnge SwitchValue.
    #15000000
    $display("Change without reset");
    Count=Countval-3000;
    SwitchValue=(Countval-3000)/2;
    //random value
    #15000000
    $display("Random value test");
    val=$random(seed)%502;
    #1
    #1$display(val);
    Prescaler=val;
    #1
    val=$random(seed)%30000;
    #1
    Count=val;
    val2=$random(seed)%32; //ensure SwitchValue doesn't result in it being zero.
    #1$display(val);
    $display(val2);
    SwitchValue=val/val2;

end



endmodule