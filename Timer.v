//16 bit by default
module Timer (input CLK, input _RST, input [15:0] Prescaler, input [15:0] Count,  input [15:0] SwitchValue, output TimerOut);

reg TimerOutput;
reg [15:0] counter;
reg [15:0] prescalercounter;

assign TimerOut=TimerOutput;

initial begin 
counter<=0;
prescalercounter<=0;
end


always @ (posedge CLK or negedge _RST) begin
    if (_RST==0) begin
        counter<=0;
        prescalercounter<=0;
    end
    else begin
        if (counter>=Count) begin
            counter<=0;
        end
        if (prescalercounter>= Prescaler) begin
            counter<=counter+1;
            prescalercounter<=0;
        end
        else if (counter>= SwitchValue) begin
            TimerOutput<=1;
        end
        else begin
            prescalercounter<=prescalercounter+1;
            TimerOutput<=0;
        end
    end
end

endmodule