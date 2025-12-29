module Clock_Divider # (parameter DivisionFactor =2) (input CLK,input _RST, output reg NewCLK);

reg[$clog2(DivisionFactor)-1:0] DivideCounter;
initial begin
    NewCLK<=0;
end
always @ (posedge CLK or negedge _RST) begin
    if (_RST==0) begin
        DivideCounter<=0;
        NewCLK<=0;
    end
    else begin
        if (DivideCounter>=DivisionFactor-1) begin
            NewCLK=~NewCLK;
        end
        else begin
            DivideCounter<=DivideCounter+1;
        end
    end


end



endmodule