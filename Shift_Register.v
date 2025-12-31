//just takes in an external input and can be read.  Not too complicated.
module RX_SPI_Shift_Register
(
input CLK,
input _HOLD,
input _RST,
input DataIn,
output [7:0] RXDataLine
);
    reg [7:0] ShiftRegister;
    reg [3:0] i;
    initial begin
        ShiftRegister<=0;
    end
    assign RXDataLine=ShiftRegister;

    always @(posedge CLK or negedge _RST) begin
        if (_RST==0) begin
            ShiftRegister<=0;
        end
        else if (_HOLD==0) begin
            for (i=7;i>0;i=i-1) begin
                ShiftRegister[i]<=ShiftRegister[i-1];
            end
            ShiftRegister[0]<=DataIn;
        end
    end


endmodule

/*
Essentially how this module works is it shifts out data bit by bit.  It is updated either on _RST==0 or after one byte has been transferred.
For a slave device this makes sense since for the first byte it is not known what you want anyways.  So application logic can control what to send based on what has been sent.

*/
module TX_SPI_Shift_Register
(
input CLK,
input _HOLD,
input _RST,
input [7:0] TXDataLine,
output [7:0] RXDataLine, //for simulation not meant for actual design.
output DataOut
);
    reg [7:0] ShiftRegister;
    reg [3:0] i;
    //meant for determining when to load in the next byte.
    reg [3:0] j;
    initial begin
        ShiftRegister<=0;
    end
    assign DataOut=ShiftRegister[7];
    assign RXDataLine=ShiftRegister;

    always @(posedge CLK or negedge _RST) begin
        //load a byte
        if (_RST==0) begin
            ShiftRegister<=TXDataLine;
            j<=0;
        end
        
        else if (_HOLD==0) begin
            
            if (j<7) begin
                for (i=7;i>0;i=i-1) begin
                    ShiftRegister[i]<=ShiftRegister[i-1];
                end
                ShiftRegister[0]<=0;
                j<=j+1;

            end
            //load the next byte for the next transfer!
            if (j>=7) begin
                ShiftRegister<=TXDataLine;
                j<=0;
            end
        end
        
    end
endmodule