`timescale 1ns/1ns
//works as intended.
module PWM_Register_tb();

reg CLK;
reg _Write;
reg [7:0] AddressBus;
reg [7:0] DataIn;
reg _HOLD;
reg _RST;
wire PWMOutput1;
wire PWMOutput2;

//test two registers.
PWMRegister #(.StartAddress(0)) TestRegister (.CLK(CLK),._Write(_Write),.AddressBus(AddressBus),.DataIn(DataIn),._HOLD(_Hold),._RST(_RST),.PWMOut(PWMOutput1));
PWMRegister #(.StartAddress(6)) TestRegister2 (.CLK(CLK),._Write(_Write),.AddressBus(AddressBus),.DataIn(DataIn),._HOLD(_Hold),._RST(_RST),.PWMOut(PWMOutput2));


initial begin
    CLK=0;
    forever begin
        #25 CLK=~CLK;
    end
end

initial begin
    $dumpfile("PWM.vcd");
    $dumpvars(0,PWM_Register_tb);
    $display("Reset");
    $monitor(PWMOutput1);
    //Reset
    _RST=0;
    _HOLD=0;
    #1
    _Write=0;
    AddressBus=0;
    DataIn=0;
    #1
    _RST=1;
    _Write=1;
    //write to first register switch upper.
    $display("First Register");
    #1

    DataIn=2;
    AddressBus=0;
    write;
    //Lower switch
    #1

    DataIn=255;
    AddressBus=1;
    write;
    #1

    //upper timer count
    DataIn=4;
    AddressBus=2;
    write;
    #1

    //Lower timer count
    DataIn=255;
    AddressBus=3;
    write;
    //Prescaler upper
    DataIn=0;
    AddressBus=4;
    write;
    #1

    //Prescaler lower
    DataIn=15;
    AddressBus=5;
    write;
    #1

    //Write to second register
    #10000000 //Wait 10ms
    $display("Second Register");
    //write to first register switch upper.
    DataIn=0;
    AddressBus=6;
    write;
    #1

    //Lower switch
    DataIn=200;
    AddressBus=7;
    write;
    #1

    //upper timer count
    DataIn=2;
    AddressBus=8;
    write;
    #1

    //Lower timer count
    DataIn=0;
    AddressBus=9;
    write;
    #1

    //Prescaler upper
    DataIn=0;
    AddressBus=10;
    write;
    #1

    //Prescaler lower
    DataIn=15;
    AddressBus=11;
    write;
end

task write;
begin
#1
_Write=0;
#1
_Write=1;

end
endtask
endmodule