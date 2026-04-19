`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 05:16:03 PM
// Design Name: 
// Module Name: pctarget_adder
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


module pctarget_adder(pc,immext,pcout);
input [31:0] pc,immext;
output reg[31:0] pcout;
always @(*) begin
pcout = pc+immext;
end

endmodule
