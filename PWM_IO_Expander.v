
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
    input RST,
    output MISO, 
    output [3:0] OnBoardLEDS
    );

wire [3:0] PWMOutputs;
assign OnBoardLEDS=PWMOutputs;
wire CLK;
wire _CS;
wire MISOReal;
wire MOSIReal;
wire SCLKReal;
assign SCLKReal=SCLK;
assign _CS=CS;
assign MISOReal=MISO;
assign MOSIReal=MOSI;
assign CLK=MainCLK;
Main main 
(.CLK(CLK), 
._CS(_CS),
.SCLK(SCLKReal),
.MOSI(MOSIReal),
.MISO(MISOReal),
._RST(RST),
.PWMOutputs(PWMOutputs)
);

endmodule
