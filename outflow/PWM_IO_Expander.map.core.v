
//
// Verific Verilog Description of module PWM_IO_Expander
//

module PWM_IO_Expander (MainCLK, CS, SCLK, MOSI, RST, MISO, OnBoardLEDS);
    input MainCLK /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(5)
    input CS /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(6)
    input SCLK /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(7)
    input MOSI /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(8)
    input RST /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(9)
    output MISO /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(10)
    output [3:0]OnBoardLEDS /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(11)
    
    
    assign MISO = 1'b0 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(10)
    assign OnBoardLEDS[3] = 1'b0 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(11)
    assign OnBoardLEDS[2] = 1'b0 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(11)
    assign OnBoardLEDS[1] = 1'b0 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;   // C:\Users\Timothy Marchant\.efinity\project\PWM_IO_Expander\PWM_IO_Expander.v(11)
    assign OnBoardLEDS[0] = 1'b0 /* verific EFX_ATTRIBUTE_CELL_NAME=GND */ ;
    
endmodule
