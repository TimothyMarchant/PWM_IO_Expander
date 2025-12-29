//Three states Idle->FirstTransfer->nthTransfer.
module SPI_FSM(input CLK, input _CS, input _RST, output [2:0] State); //reset when chip select is LOW

reg [2:0] CurrentState;
reg NewTransfer;


assign State=CurrentState;

always @ (posedge CLK or negedge _RST) begin
    if (_RST==0) begin
        CurrentState<=0;
    end
    else begin
        if (_CS==0) begin
            if (NewTransfer==1) begin
                NewTransfer<=0;
                CurrentState<=1;
            end
            else begin

            end
        end

    end



end

always @ (posedge _CS or negedge _RST) begin
    NewTransfer<=1;

end

endmodule