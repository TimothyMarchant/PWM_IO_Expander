`timescale 1ns/1ns

module Main_tb();
    reg CLK;
    reg _CS;
    reg _RST;
    reg _RSTMain;
    reg SCLK;
    wire MOSI;
    wire MISO;
    wire [3:0] PWMOutputs;
    reg [7:0] TXInput;
    integer i;
    integer seed=1;
    reg[7:0] val;
    reg[7:0] StartAddress;
    //we need to simply check whether or not us sending information updates the outputs accordingly.
    Main testmain(.CLK(CLK),._CS(_CS),.SCLK(SCLK),.MOSI(MOSI),.MISO(MISO),._RST(_RSTMain),.PWMOutputs(PWMOutputs));
    TX_SPI_Shift_Register shiftregister(.CLK(SCLK),._HOLD(_CS),._RST(_RST),.TXDataLine(TXInput),.RXDataLine(),.DataOut(MOSI));
    initial begin
        CLK=0;
        forever begin
            #25 CLK=~CLK;
        end

    end
    initial begin
        $dumpfile("Main.vcd");
        $dumpvars(0,Main_tb);
        //reset
        TXInput=0;
        #1
        _RST=0;
        _RSTMain=0;
        #1
        _CS=1;
        SCLK=0;
        val=0;
        #1
        _RSTMain=1;
        _RST=1;
        #1
        $display("Writing to first register");
        StartAddress=0;
        WriteRegisters;
        $display("Writing to Second Register");
        StartAddress=6;
        WriteRegisters;
        $display("Writing to Third Register");
        StartAddress=12;
        WriteRegisters;
        $display("Writing to Fourth Register");
        StartAddress=18;
        WriteRegisters;
        $display("Finished");
        #10000000 //wait 20ms
        //Need to check if writing to only part of the register works fine.
        //That is only make two writes, address write then register write.
        $display("Write only part of a register");
        TXInput=5; //update prescaler value  Decrease it.
        #1
        _RST=0;
        #1
        _RST=1;
        #1
        BeginTransfer;
        TXInput=0; //will make the counter 5 times faster.
        SPITransfer;
        SPITransfer;
        EndTransfer;
        #50000000
        $display("Actually done");
        $finish; //end simulation
    end

    task WriteRegisters;
    begin
        //write to address register.  Set Address.
        TXInput=StartAddress;
        #1
        _RST=0;
        #1
        #1
        _RST=1;
        #1
        BeginTransfer;
        //SWITCHVALUE REGISTER
        //load in first value for first upper register. 
        GetRandomValue;
        TXInput=2;
        SPITransfer;
        GetRandomValue;
        //LOWER
        TXInput=val;
        SPITransfer;
        GetRandomValue;
        //COUNTVALUE REGISTER
        //upper
        TXInput=4;
        SPITransfer;
        GetRandomValue;

        TXInput=val;
        SPITransfer;
        GetRandomValue;
        //PRESCALER REGISTER.
        //upper
        TXInput=0;
        SPITransfer;
        GetRandomValue;
        //load last value before last transfer.
        TXInput=4;
        SPITransfer;
        //Transfer last byte loaded in.
        SPITransfer;
        EndTransfer;
    end
    endtask
    task GetRandomValue;
    begin
        val=$random(seed)%255;
        $display(val);
    end
    endtask

    task SPITransfer;
    begin
        SCLK=0;
        for (i=7;i>=0;i=i-1) begin
            #5
            SCLK=1;
            #5
            SCLK=0;
        end
    end
    endtask
    task EndTransfer;
    begin
        #10 _CS=1; //realistcally this is much faster than it would take in software.  Most ISRs take a few clockcycles to be reached anyways (especissaly in sleep).
    end

    endtask
    task BeginTransfer;
    begin
        #1 _CS=0;
        
    end
    endtask

endmodule