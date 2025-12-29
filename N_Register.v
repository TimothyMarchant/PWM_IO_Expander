module N_Bit_Register #(parameter BitWidth=8) (input CLK, input _HOLD, input _RST, input[BitWidth-1:0] DataIn,output[BitWidth-1:0] DataOut);

reg [BitWidth-1:0] Registers;

assign DataOut=Registers;

initial begin
    Registers<=0;
end



always @(posedge CLK or negedge _RST) begin
    if (_RST==0) begin 
        Registers<=0;
    end
    else if (_HOLD==1) begin
        Registers<=DataIn;
    end
    


end




endmodule