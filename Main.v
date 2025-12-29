
//hardware indepedent design
module Main #(parameter NumOfPWMOutputs=4) (input CLK, input _CS, input SCLK, input MOSI, output MISO, output [NumOfPWMOutputs-1:0] PWMOutputs);
//declarations
    wire TransferComplete;
    wire _Write;
    reg FirstByteReceived;
    wire [7:0] SPIRXOutput;
   // wire [7:0] SPITXInput;
    wire [7:0] AddressBus;
    wire [7:0] WriteBus;
    wire [7:0] NewAddress;


    supply0 [7:0] PullDowns;
//assignments
assign WriteBus = _Write ? PullDowns : SPIRXOutput;
assign NewAddress = FirstByteReceived ? PullDowns : SPIRXOutput;
assign _Write= ~(TransferComplete&FirstByteReceived);
//module instatnations.

    always @ (posedge SCLK) begin
        if (TransferComplete==1) begin
            FirstByteReceived<=1; //set after receiving a byte.  Doesn't matter after the first byte.
        end
        else if (_CS==0) begin //beginning transfer.  
            FirstByteReceived<=0;
        end
    end


    SPI_Slave spislave 
    (.SCLK(SCLK),
    .MOSI(MOSI),
    .TXDataLine(),
    ._CS(_CS),
    ._RST('b1),
    .MISO(MISO),
    .RXDataLine(SPIRXOutput),
    .TranscationCompleted(TransferComplete)
    );


    AddressPointer AddressPtr (
    .CLK(CLK),
    ._RST('b1),
    .NewAddress(NewAddress),
    .AddressBus(AddressBus)
    );

    PWMRegister #(.StartAddress(0)) FirstRegister 
    (.CLK(CLK),
    ._Write(_Write),
    .AddressBus(AddressBus),
    .DataIn(WriteBus),
    ._HOLD('b0),
    ._RST('b1),
    .PWMOut(PWMOutputs[0])
    );

    PWMRegister #(.StartAddress(6)) SecondRegister 
    (.CLK(CLK),
    ._Write(_Write),
    .AddressBus(AddressBus),
    .DataIn(WriteBus),
    ._HOLD('b0),
    ._RST('b1),
    .PWMOut(PWMOutputs[1])
    );

    PWMRegister #(.StartAddress(12)) ThirdRegister 
    (.CLK(CLK),
    ._Write(_Write),
    .AddressBus(AddressBus),
    .DataIn(WriteBus),
    ._HOLD('b0),
    ._RST('b1),
    .PWMOut(PWMOutputs[2])
    );

    PWMRegister #(.StartAddress(18)) FourthRegister 
    (.CLK(CLK),
    ._Write(_Write),
    .AddressBus(AddressBus),
    .DataIn(WriteBus),
    ._HOLD('b0),
    ._RST('b1),
    .PWMOut(PWMOutputs[3])
    );
endmodule
