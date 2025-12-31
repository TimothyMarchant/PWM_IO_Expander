
//Meant for device specific stuff nothing else.
/*
MainCLK is meant for driving the timers.  It doesn't control anything regarding registers or writes.
SCLK controls everything, so there are no real concerns with MainCLK.
MISO is marked, but isn't used currently.

*/
module PWM_IO_Expander (
    input MainCLK, 
    input CS, 
    input SCLK, 
    input MOSI, 
    input RST, //active LOW
    input EN, //active HIGH (Pull low to disable).
    output MISO, 
    output [3:0] OnBoardLEDS
    );
//declarations
wire [3:0] PWMOutputs; //generic wire for outputs of PWM registers.  Can increase size for more external GPIO.
wire CLK;
//assignments
assign OnBoardLEDS=~PWMOutputs; //external GPIO are open drain.

//instantion.
Main main 
(.CLK(MainCLK), 
._CS(CS),
.SCLK(SCLK),
.MOSI(MOSI),
.MISO(MISO),
._RST(RST),
.EN(EN),
.PWMOutputs(PWMOutputs)
);

//required by efinix synthesis software.
reg dummy;
initial begin
    dummy<=0;
end
always @ (posedge MainCLK) begin
    dummy<=~dummy;
end

endmodule
