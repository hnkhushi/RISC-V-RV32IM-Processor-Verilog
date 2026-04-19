`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 05:13:12 PM
// Design Name: 
// Module Name: read_mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module read_mux(aluresult,rd,sel,dataout,mresult);
input [31:0] aluresult,rd;
input [31:0] mresult;
input [1:0] sel;
output reg [31:0] dataout;
always @(*) begin
case(sel)
2'b00: dataout=aluresult;
2'b01: dataout=rd;
2'b10: dataout=mresult;
default: dataout=rd;
endcase
end

endmodule
