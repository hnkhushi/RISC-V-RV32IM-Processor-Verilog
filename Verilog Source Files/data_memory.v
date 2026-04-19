`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 04:56:30 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(clk,wd,we,a,rd);
input clk,we;
input [31:0] a,wd;
output [31:0] rd;
reg [31:0] memory[63:0];
assign rd=memory[a[31:2]];

always @(posedge clk) begin
if(we) memory[a[31:2]]<=wd;
end

endmodule
