`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 01:27:34 PM
// Design Name: 
// Module Name: b_mux
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


module b_mux(regin,immin,alusrc,bout);
input [31:0] regin,immin;
input alusrc;
output reg [31:0] bout;

always @(*) begin
bout<=(alusrc==1)?immin:regin;
end

endmodule
