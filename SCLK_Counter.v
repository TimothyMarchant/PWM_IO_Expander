module SCLK_Counter 
(
input CLK, 
input _CS, 
input _RST, 
output CounterOutput,
output [3:0] Counter
);

    //localparam MaxCount = 7;
    wire CounterFinalOutput;
    wire CounterFinalOutputNegate;
    reg[3:0] SCLKCounter;
    reg CounterFinished;
    initial begin
        CounterFinished<=0;
        SCLKCounter<=0;
    end
    assign Counter=SCLKCounter;
    assign CounterOutput=CounterFinished; //when count==7
    assign CounterFinalOutput=SCLKCounter[3]; //needed for Setting Transfer completion register.
    //Synthsis requires this.
    assign CounterFinalOutputNegate=~CounterFinalOutput; //Essentially On this positive edge it just runs an always block and clears the completed transfer register.
    always @ (posedge CLK or posedge _CS or negedge _RST) begin
        if (_RST==0) begin
            SCLKCounter<=0;
        end
        //If the previous condidition is met ignore this statement.  This is if CS is pulled high early mid transmission.
        else if (_CS==1) begin
            SCLKCounter<=0;
        end
        //_CS cannot be high.
        else begin
            SCLKCounter<=SCLKCounter+1;
            //This waits for one more full edge
            if (SCLKCounter>=8) begin
                SCLKCounter<=1;
            end
        end
    end
    //Synthsis required this.
    always @(posedge CounterFinalOutput or posedge CounterFinalOutputNegate) begin
        if (CounterFinalOutput) begin
        CounterFinished<=1;
        end
        else begin 
        CounterFinished<=0;
        end

    end
endmodule