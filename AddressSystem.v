module AddressPointer # (parameter AddressWidth=8) (input CLK, input _RST, input [AddressWidth-1:0] NewAddress, output [AddressWidth-1:0] AddressBus);

reg [AddressWidth-1:0] AddressRegister;
assign AddressBus=AddressRegister;

always @ (posedge CLK or negedge _RST) begin
    if (_RST==0) begin
        AddressRegister<=0;
    end
    else begin
        AddressRegister<=NewAddress;
    end
end

endmodule