`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 10:48:00 AM
// Design Name: 
// Module Name: register_file
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


module register_file(clk,a1,a2,a3,wd3,we,rd1,rd2);
input clk,we;
input [4:0] a1,a2,a3;
input [31:0] wd3;
output reg [31:0] rd1,rd2;

reg [31:0] rf[31:0];
integer i;
initial begin
  for (i = 0; i < 32; i = i + 1)
      rf[i] = 0;
end

always @(*) begin
rd1<=(a1==0)?0:rf[a1];
rd2<=(a2==0)?0:rf[a2];
end

always @ (posedge clk) begin
if (we==1 && a3!=0) begin
rf[a3]<=wd3;
end
end

endmodule
