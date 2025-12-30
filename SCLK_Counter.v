module SCLK_Counter 
(
input CLK, 
input _CS, 
input _RST, 
output CounterOutput,
output [3:0] Counter
);
    wire CounterFinalOutput;
    reg[3:0] SCLKCounter;
    reg CounterFinished;
    initial begin
        CounterFinished<=0;
        SCLKCounter<=0;
    end
    assign Counter=SCLKCounter;
    assign CounterOutput=CounterFinished; //when count==7
    assign CounterFinalOutput=SCLKCounter[3]; //needed for Setting Transfer completion register.
    /*
        There is a timing requirement for when _CS is allowed to be pulled high for this counter to work correctly.
        Let us just assume the minimum hold time for any register we would update outside of SPI_Slave is 1 ns with a propagation delay of 5ns.
        This implies that after the final clock pulse, a full high to low transisition must occur and then _CS is allowed to be pulled high.
        That is to say _CS must wait One SCLK Half period plus 6ns before being pulled high.  SPI idles LOW so timing shouldn't be a problem at sub 25MHz speeds.
    */

    always @ (posedge CLK or posedge _CS or negedge _RST) begin
        if (_RST==0) begin
            SCLKCounter<=0;
        end
        //Reset counter when _CS is HIGH.  Must wait the required time listed above.
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
    //Check for updates on negedge of CLK or if the final output goes to zero.
    always @(negedge CLK or negedge CounterFinalOutput) begin
        if (CounterFinalOutput) begin
        CounterFinished<=1;
        end
        else begin 
        CounterFinished<=0;
        end

    end
endmodule