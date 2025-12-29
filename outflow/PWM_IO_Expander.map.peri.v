// Efinix verilog description of module PWM_IO_Expander
// Date : Dec 29 2025  11:26
// Copyright (C) 2013-2025 Efinix Inc. All rights reserved.

module PWM_IO_Expander (MainCLK, CS, SCLK, MOSI, RST, MISO, OnBoardLEDS);
    input MainCLK;
    input CS;
    input SCLK;
    input MOSI;
    input RST;
    output MISO;
    output [3 : 0] OnBoardLEDS;


    \PWM_IO_Expander~core  \PWM_IO_Expander~core~inst  (.MainCLK(\MainCLK~EFX_IBUF~O ), .CS(\CS~EFX_IBUF~O ), .SCLK(\SCLK~EFX_IBUF~O ), .MOSI(\MOSI~EFX_IBUF~O ), .RST(\RST~EFX_IBUF~O ), .MISO(\MISO~EFX_OBUF~I ), .OnBoardLEDS({\OnBoardLEDS[3]~EFX_OBUF~I , \OnBoardLEDS[2]~EFX_OBUF~I , \OnBoardLEDS[1]~EFX_OBUF~I , \OnBoardLEDS[0]~EFX_OBUF~I }));
    EFX_IBUF \MainCLK~EFX_IBUF  (.I(MainCLK), .O(\MainCLK~EFX_IBUF~O )) /* EFX_ATTRIBUTE_CELL_NAME=EFX_IBUF, PULL_OPTION="NONE" */ ;
    defparam \MainCLK~EFX_IBUF .PULL_OPTION = "NONE";
    EFX_IBUF \CS~EFX_IBUF  (.I(CS), .O(\CS~EFX_IBUF~O )) /* EFX_ATTRIBUTE_CELL_NAME=EFX_IBUF, PULL_OPTION="NONE" */ ;
    defparam \CS~EFX_IBUF .PULL_OPTION = "NONE";
    EFX_IBUF \SCLK~EFX_IBUF  (.I(SCLK), .O(\SCLK~EFX_IBUF~O )) /* EFX_ATTRIBUTE_CELL_NAME=EFX_IBUF, PULL_OPTION="NONE" */ ;
    defparam \SCLK~EFX_IBUF .PULL_OPTION = "NONE";
    EFX_IBUF \MOSI~EFX_IBUF  (.I(MOSI), .O(\MOSI~EFX_IBUF~O )) /* EFX_ATTRIBUTE_CELL_NAME=EFX_IBUF, PULL_OPTION="NONE" */ ;
    defparam \MOSI~EFX_IBUF .PULL_OPTION = "NONE";
    EFX_IBUF \RST~EFX_IBUF  (.I(RST), .O(\RST~EFX_IBUF~O )) /* EFX_ATTRIBUTE_CELL_NAME=EFX_IBUF, PULL_OPTION="NONE" */ ;
    defparam \RST~EFX_IBUF .PULL_OPTION = "NONE";
    EFX_OBUF \MISO~EFX_OBUF  (.I(\MISO~EFX_OBUF~I ), .O(MISO)) /* EFX_ATTRIBUTE_CELL_NAME=EFX_OBUF */ ;
    EFX_OBUF \OnBoardLEDS[3]~EFX_OBUF  (.I(\OnBoardLEDS[3]~EFX_OBUF~I ), .O(OnBoardLEDS[3])) /* EFX_ATTRIBUTE_CELL_NAME=EFX_OBUF */ ;
    EFX_OBUF \OnBoardLEDS[2]~EFX_OBUF  (.I(\OnBoardLEDS[2]~EFX_OBUF~I ), .O(OnBoardLEDS[2])) /* EFX_ATTRIBUTE_CELL_NAME=EFX_OBUF */ ;
    EFX_OBUF \OnBoardLEDS[1]~EFX_OBUF  (.I(\OnBoardLEDS[1]~EFX_OBUF~I ), .O(OnBoardLEDS[1])) /* EFX_ATTRIBUTE_CELL_NAME=EFX_OBUF */ ;
    EFX_OBUF \OnBoardLEDS[0]~EFX_OBUF  (.I(\OnBoardLEDS[0]~EFX_OBUF~I ), .O(OnBoardLEDS[0])) /* EFX_ATTRIBUTE_CELL_NAME=EFX_OBUF */ ;
endmodule// PWM_IO_Expander