module FIFO #(parameter Width=8) (input [Width-1:0] DataIn, input TransferComplete, output [Width-1:0] FIFOOutput);
reg [Width-1:0] fifo;
assign FIFOOutput=fifo;
always @ (posedge TransferComplete) begin
    fifo<=DataIn;
end


endmodule