//16 bit by default.  I looked at how the STM32 timer worked and took some inspiration from that.
module Timer (input CLK, input _RST, input [15:0] Prescaler, input [15:0] Count,  input [15:0] SwitchValue, output TimerOut);

reg TimerOutput;
reg [15:0] counter;
reg [15:0] prescalercounter;

assign TimerOut=TimerOutput;

initial begin 
counter<=0;
prescalercounter<=0;
TimerOutput<=0;
end


always @ (posedge CLK or negedge _RST) begin
    if (_RST==0) begin
        counter<=0;
        prescalercounter<=0;
        TimerOutput<=0;
    end
    else begin
        //reset counter when it reaches the max value in the Count Register.
        if (counter>=Count) begin
            counter<=0;
        end
        //increment counter once the Prescaler has been counted to.
        if (prescalercounter>= Prescaler+1) begin
            counter<=counter+1;
            prescalercounter<=0;
        end
        else begin
            prescalercounter<=prescalercounter+1;
            //if counter>= SwitchValue switch the polarity of the timer output.  Starts HIGH then LOW.
            if (counter>= SwitchValue) begin
                TimerOutput<=0;
            end
            else begin
                TimerOutput<=1;
            end
        end

    end
end

endmodule