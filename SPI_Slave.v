module SPI_Slave(
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
RX_SPI_Shift_Register RXSPIShiftRegister(.CLK(SCLK),._HOLD(_CS),._RST(_RST), .DataIn(MOSI),.RXDataLine(RXDataLine));
TX_SPI_Shift_Register TXSPIShiftRegister(.CLK(SCLK),._HOLD(_CS),._RST(_RST), .TXDataLine(TXDataLine),.RXDataLine(SecondRXDataLine),.DataOut(MISO));

assign TranscationCompleted=CounterFinished;
SCLK_Counter Counter(.CLK(SCLK),._CS(_CS),._RST(_RST),.CounterOutput(CounterFinished),.Counter(CounterOutput));

endmodule