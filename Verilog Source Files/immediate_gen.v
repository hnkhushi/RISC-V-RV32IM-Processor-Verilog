`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2026 12:53:17 PM
// Design Name: 
// Module Name: immediate_gen
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


module immediate_gen(instr,imsrc,imout);
input [31:0] instr;
input [1:0] imsrc;
output reg [31:0] imout;

always @(*) begin
case(imsrc)
2'b00: imout <= {{20{instr[31]}},{instr[31:20]}};
2'b01: imout <= {{20{instr[31]}},{instr[31:25]},{instr[11:7]}};
2'b10: imout <= {{19{instr[31]}},{instr[31]},{instr[7]},{instr[30:25]},{instr[11:8]},{1'b0}};
2'b11: imout <= {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
endcase
end

endmodule
