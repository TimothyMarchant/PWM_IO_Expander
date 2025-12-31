
//hardware indepedent design
module Main #(parameter NumOfPWMOutputs=4) (input CLK, input _CS, input SCLK, input MOSI, output MISO, input _RST, input EN, output [NumOfPWMOutputs-1:0] PWMOutputs);
//declarations
    wire TransferComplete;
    wire _Write;
    wire AddressWrite; //active HIGH.
    reg[1:0] FirstByteReceived;
    reg TransferCompleteDelayReg;
    wire [7:0] SPIRXOutput;
    wire [7:0] AddressBus;
    wire [7:0] WriteBus;
    wire [7:0] FirstAddress;
    wire FirstByteReceivedOut;

//assignments
assign WriteBus = SPIRXOutput;
assign FirstAddress = SPIRXOutput;
assign AddressWrite= FirstByteReceived[1] ? TransferCompleteDelayReg : TransferComplete; //essentially delay address writing after the first byte has been received.
assign _Write = ~(TransferComplete&FirstByteReceived[1]);
assign FirstByteReceivedOut = FirstByteReceived[0]|FirstByteReceived[1];
assign GatedCLK=CLK&EN; //Clock gating.  Allows user to disable all timers for some sort of power saving.
initial begin
    FirstByteReceived<=0;
    TransferCompleteDelayReg<=0;
end
//meant for determining where to send data.  The first byte is an address.  The nth byte is data for a register.
//When this posedge occurs The register here will become a 1, but the Transfercomplete reg will become a zero.
    always @ (posedge SCLK or negedge _RST or posedge _CS) begin
        if (_RST==0) begin
            FirstByteReceived<=0;
            TransferCompleteDelayReg<=0;
        end
        else begin
            if (_CS==1) begin //end of transfer.  Must meet requirements in SCLK_Counter.v.  
            FirstByteReceived<='b00;
            TransferCompleteDelayReg<=0;
            end
            else begin
         if (TransferComplete==1) begin
            FirstByteReceived<='b01; //set after receiving a byte.  Doesn't matter after the first byte.
            TransferCompleteDelayReg<=1; //delay address writing.
        end
         if (FirstByteReceived==1) begin
            FirstByteReceived<='b10; //set this so _Write is delayed for the first transfer.  Prevents accidental writes.
        end
        
         if (TransferComplete==0) begin
            TransferCompleteDelayReg<=0;
        end
        end
        end
    end
//module instanations.

    SPI_Slave #(.TXEnable(0)) spislave 
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
    .CLK(AddressWrite),
    ._RST(_RST),
    .FirstByteReceived(FirstByteReceivedOut),
    .FirstAddress(FirstAddress),
    .AddressBus(AddressBus)
    );
    genvar i;
    generate
        for (i=0;i<NumOfPWMOutputs;i=i+1) begin
        PWMRegister #(.StartAddress(6*i)) FirstRegister 
        (.CLK(GatedCLK),
        ._Write(_Write),
        .AddressBus(AddressBus),
        .DataIn(WriteBus),
        ._RST(_RST),
        .PWMOut(PWMOutputs[i])
    );
        end

    endgenerate
endmodule
