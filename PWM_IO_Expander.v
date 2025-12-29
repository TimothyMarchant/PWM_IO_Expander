
//Meant for device specific stuff nothing else.

module PWM_IO_Expander (
    (* syn_preserve = "true" *) input MainCLK, 
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
assign CLK=MainCLK;
Main main 
(.CLK(CLK),
._CS(CS),
.SCLK(SCLK),
.MOSI(MOSI),
.MISO(MISO),
.PWMOutputs(PWMOutputs)
);

endmodule
