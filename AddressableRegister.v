module AddressableRegister # (parameter AddressWidth=8,parameter [AddressWidth-1:0] AddressValue='h00, parameter BitWidth=8, parameter WriteOnly=1) 
(input CLK, input _HOLD, input _RST, input[AddressWidth-1:0] AddressBus, input[BitWidth-1:0] DataIn,output [BitWidth-1:0] DataOut);
    wire [AddressWidth-1:0] Address;
    wand Addressed;
    wire CanReset;
    wire CanWrite;
    tri [BitWidth-1:0] ReadBus;


    genvar i;

    for (i=0;i<AddressWidth;i=i+1) begin
        if (AddressValue[i]==0)
            assign Address[i]=~AddressBus[i]; //NOT (make sure that a zero at this position makes the input a 1.)
        else
            assign Address[i]=AddressBus[i]; //BUFFER
    end

    
    for (i=0;i<AddressWidth;i=i+1) begin
        assign Addressed=Address[i];
    end
    
    assign CanReset=~(~_RST&Addressed);
    assign CanWrite=~(~_HOLD&Addressed);

    if (WriteOnly==0) begin
        N_Bit_Register #(.BitWidth(BitWidth)) Register(.CLK(CLK),._HOLD(CanWrite),._RST(CanReset),.DataIn(DataIn),.DataOut(ReadBus));
        ReadBusMultiplexer #(.Width(BitWidth)) Multiplexer (.ReadBus(ReadBus),.Addressed(Addressed),.Output(DataOut));
    end
    else begin
        N_Bit_Register #(.BitWidth(BitWidth)) Register(.CLK(CLK),._HOLD(CanWrite),._RST(CanReset),.DataIn(DataIn),.DataOut(DataOut));

      //  assign DataOut=ReadBus;
    end


endmodule
module ReadBusMultiplexer #(parameter Width=8) (input [Width-1:0] ReadBus,input Addressed,output [Width-1:0] Output);
    wire [Width-1:0] hiz;
    genvar i;
    for (i=0;i<Width;i=i+1) begin
        assign hiz[i]='bz;
    end
    assign Output=Addressed ? ReadBus : hiz;

endmodule