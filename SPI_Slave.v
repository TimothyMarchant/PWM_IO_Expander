//Module necessary for a SPI_Slave pheripheral.  
module SPI_Slave #(parameter RXEnable=1,parameter TXEnable=1)(
    input SCLK,
    input MOSI,
    input [7:0] TXDataLine, 
    input _CS, 
    input _RST,
    output MISO, 
    output [7:0] RXDataLine, 
    output TranscationCompleted
    );

wire [7:0] SecondRXDataLine;// simulation purposes.
wire [3:0] CounterOutput;
wire CounterFinished;
//handles RX activities.
if (RXEnable==1) begin
RX_SPI_Shift_Register RXSPIShiftRegister(.CLK(SCLK),
._HOLD(_CS),
._RST(_RST), 
.DataIn(MOSI),
.RXDataLine(RXDataLine)
);
end
//Handles TX activities.
if (TXEnable==1) begin
TX_SPI_Shift_Register TXSPIShiftRegister(.CLK(SCLK),
._HOLD(_CS),
._RST(_RST),
 .TXDataLine(TXDataLine), //load data in either on reset or after the first byte has been received.
 .RXDataLine(SecondRXDataLine), //Meant for reading the register for simulation purposes.
 .DataOut(MISO)
 );
end
//Meant for determining if a byte has been received or not.  Tells if 
assign TranscationCompleted=CounterFinished;
SCLK_Counter Counter(.CLK(SCLK),
._CS(_CS),
._RST(_RST),
.CounterOutput(CounterFinished), //actual output
.Counter(CounterOutput) //For similuation purposes.  No use case outside of it.
);

endmodule