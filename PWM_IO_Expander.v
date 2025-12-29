
//Meant for device specific stuff nothing else.

module PWM_IO_Expander (
    input MainCLK, 
    input CS, 
    input SCLK, 
    input MOSI, 
    //input RST,
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
.PWMOutputs(PWMOutputs)
);

endmodule
