module SPI_Slave_tb(); //Seems to be working as intended.

    reg SCLK;
    wire MOSI;
    reg [7:0] SlaveTXDataLine;
    reg [7:0] MasterTXDataLine;

    reg _CS;
    reg _RST;
    wire MISO;
    wire [7:0] RXDataLine;
    wire [7:0] MasterRXDataLine;

    wire [7:0] SecondRXDataLine;

    wire TranscationCompleted;

    wire [7:0] MasterTXRegister;
    wire [7:0] MasterRXRegister;
    reg [7:0] SlaveTXVal;
    reg [7:0] MasterTXVal;

    integer seed=5;
    integer i;
    //Setup slave instance.  We only know it's rx value and if a transcation is completed.  Treat the inside like a black box.
    SPI_Slave Test (.SCLK(SCLK),.MOSI(MOSI),.TXDataLine(SlaveTXDataLine),._CS(_CS),._RST(_RST),.MISO(MISO),.RXDataLine(RXDataLine),.TranscationCompleted(TranscationCompleted));
    //create master shift registers.  Simulates actual SPI.
    RX_SPI_Shift_Register MasterRX(.CLK(SCLK),._HOLD(_CS),._RST(_RST), .DataIn(MISO),.RXDataLine(MasterRXDataLine));
    TX_SPI_Shift_Register MasterTX(.CLK(SCLK),._HOLD(_CS),._RST(_RST), .TXDataLine(MasterTXDataLine),.RXDataLine(SecondRXDataLine),.DataOut(MOSI));
    initial begin
    //reset
    $display("Reset");

    SlaveTXDataLine<=0;
    MasterTXDataLine<=0;
    SCLK<=0;
    _CS<=1;

    #1
    _RST=0;
    #1
    _RST=1;
    #1
    printRegisters;
    //Send one byte and receive one in return.
    $display("Send one byte after reset");
    SlaveTXVal=$random(seed)%127;
    MasterTXVal=$random(seed)%16;
    #1
    SlaveTXDataLine=SlaveTXVal;
    MasterTXDataLine=MasterTXVal;
    //this reset is necessary to load the first byte.  Otherwise a dummy byte must be sent first.
    #1
    _RST=0;
    #1
    _RST=1;
    #1
    printRandomValues;
    
    _CS=0;

    printRegisters;
    printByteReceived;
    TransferByte;
    printRegisters;
    printByteReceived;
    _CS=1;
    printRegisters;
    printByteReceived;
    //Reset and send two bytes.
    $display("Reset and then send two bytes.");
    
    SlaveTXVal=$random(seed)%255;
    MasterTXVal=$random(seed)%255;
    #1
    SlaveTXDataLine=SlaveTXVal;
    MasterTXDataLine=MasterTXVal;
    
    #1
    _RST=0;
    #1
    _RST=1;
    #1
    printRandomValues;

    //Next random values need to be loaded in before the next eigth clock cycle.
    SlaveTXVal=$random(seed)%255;
    MasterTXVal=$random(seed)%255;
    #1
    SlaveTXDataLine=SlaveTXVal;
    MasterTXDataLine=MasterTXVal;
    printRandomValues;


    _CS=0;
    $display("Registers at start.");
    printRegisters;
    printByteReceived;
    $display("Sending first byte.");

    TransferByte;
    printRegisters;
    printByteReceived;
    $display("Sending second byte.");

    TransferByte;
    printRegisters;
    printByteReceived;
    _CS=1;

    //Transfer two bytes, but send one dummy byte and load the next one in the middle of a transfer.
    #1
    _RST=0;
    #1
    _RST=1;

    $display("Dummy byte and mid load");
    SlaveTXVal=$random(seed)%255;
    MasterTXVal=$random(seed)%255;
    printByteReceived;
    printRandomValues;
    printRegisters;
    #1
    _CS=0;
    for (i=6;i>=0;i=i-1) begin
            #5
            SCLK=1;
            #5
            SCLK=0;
    end
    SlaveTXDataLine=SlaveTXVal;
    MasterTXDataLine=MasterTXVal;
    printByteReceived;

    #5
    SCLK=1;
    #5
    printByteReceived;

    SCLK=0;
    $display("First byte");
    printRegisters;
    printByteReceived;
    TransferByte;
    $display("Second byte");
    printRegisters;
    printByteReceived;
    _CS=1;
    end





    task TransferByte;
    begin
        for (i=7;i>=0;i=i-1) begin
            #5
            SCLK=1;
            #5
            SCLK=0;
        end
    end
    endtask

    task printRegisters;
    begin
        #5
        $display("Slave RX Register,%8b",RXDataLine);
        $display("Master RX Register,%8b",MasterRXDataLine);
        $display("Master TX Register,%8b",SecondRXDataLine);

    end
    endtask

    task printByteReceived;
    #1  $display("Is Byte received? %1b",TranscationCompleted);
    endtask

    task printRandomValues;
    begin
    #1 $display("Slave random value:%8b",SlaveTXVal);
    #1 $display("Master random value:%8b",MasterTXVal);
    end
    endtask

endmodule