module AddressPointer # (parameter AddressWidth=8) (input CLK, input _RST, input FirstByteReceived, input [AddressWidth-1:0] FirstAddress, output [AddressWidth-1:0] AddressBus);

reg [AddressWidth-1:0] AddressRegister;
assign AddressBus=AddressRegister;

initial begin
    AddressRegister<=0;
end
always @ (posedge CLK or negedge _RST) begin
    if (_RST==0) begin
        AddressRegister<=0;
    end
    else begin
        //No need to reset after a transfer is complete.  The first byte received is always the new address.
        if (FirstByteReceived==0) begin
        AddressRegister<=FirstAddress;
        end
        else begin
            AddressRegister<=AddressRegister+1; //Wraps around automatically on an overflow.  Also writing to nonexistant memory addresses doesn't cause problems.
        end
    end
end

endmodule