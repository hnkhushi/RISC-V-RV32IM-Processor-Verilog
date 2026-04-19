`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 10:27:19 AM
// Design Name: 
// Module Name: pc_plus4
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


module pc_plus4(pcprev,pcnext);
input [31:0] pcprev;
output reg [31:0] pcnext;
always @(*) begin
pcnext<=pcprev+4;
end
endmodule
