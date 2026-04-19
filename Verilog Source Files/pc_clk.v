`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 10:25:48 AM
// Design Name: 
// Module Name: pc_clk
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


module pc_clk(clk,rst,pcin,pcout,start,busy);
input clk,rst,start,busy;
input [31:0] pcin;
output reg [31:0] pcout;
wire pcen;
assign pcen = ~(start|busy);

always @ (posedge clk) begin
if (rst) pcout<= 32'b0;
else if (pcen) pcout<=pcin;
end
endmodule
