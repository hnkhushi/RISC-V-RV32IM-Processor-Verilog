`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 10:22:08 AM
// Design Name: 
// Module Name: pc_mux
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


module pc_mux(pcsrc,pcplus4,pctarget,pcnext);
input pcsrc;
input [31:0] pcplus4, pctarget;
output reg [31:0] pcnext;

always @(*) begin
pcnext<=(pcsrc==1)?pctarget:pcplus4;
end
endmodule
