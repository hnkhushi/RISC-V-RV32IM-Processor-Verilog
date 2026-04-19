`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2026 05:33:55 PM
// Design Name: 
// Module Name: ALU_Controller
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


module ALU_Controller(controlin, a, b,result,zero,less,lessu);
input [3:0] controlin;
input [31:0] a,b;
output reg zero,less,lessu;
output reg [31:0] result;

always @(*) begin
less=1'b0;
lessu=1'b0;
case(controlin)
4'b0000: result=a+b;
4'b0001: result=a-b;
4'b0010: result=a&b;
4'b0011: result=a|b;
4'b0100: 
        begin
        less=($signed(a)<$signed(b));
        result={31'b0,less}; //set less than
        end 
4'b0101: result=a<<b[4:0];
4'b0110: result=a>>b[4:0];
4'b0111: result=a^b;
4'b1000: result=$signed(a)>>>b[4:0];
4'b1001: 
        begin
        lessu=(a<b);
        result={31'b0,lessu};
        end
default: result=32'b0;
endcase
if (result==1'b0) zero=1'b1;
else zero=1'b0;
end
endmodule
