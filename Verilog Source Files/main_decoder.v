`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2026 05:16:59 PM
// Design Name: 
// Module Name: main_decoder
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


module main_decoder(op,branch,Resultsrc,MemWrite,ALUsrc,Immsrc,RegWrite,ALUop,jump,ism,start,funct7);
input [6:0] op,funct7;
output reg branch,MemWrite,ALUsrc,RegWrite,jump,ism,start;
output reg [1:0] Immsrc,ALUop,Resultsrc;
always@(*) begin
case (op)
7'b0000011: begin  //Load
jump<=1'b0;
branch<=1'b0;
Resultsrc<=2'b01;
MemWrite<=1'b0;
ALUsrc<=1'b1;
Immsrc<=2'b00;
RegWrite<=1'b1;
ALUop<=2'b00;
ism<=1'b0;
start<=1'b0;
end

7'b0100011: begin  //Store
jump<=1'b0;
branch<=1'b0;
Resultsrc<=2'b00;
MemWrite<=1'b1;
ALUsrc<=1'b1;
Immsrc<=2'b01;
RegWrite<=1'b0;
ALUop<=2'b00;
ism<=1'b0;
start<=1'b0;
end

7'b0110011: begin  //R-type
if (funct7==7'b0000000 || funct7==7'b0100000) begin
jump<=1'b0;
branch<=1'b0;
Resultsrc<=2'b00;
MemWrite<=1'b0;
ALUsrc<=1'b0;
Immsrc<=2'b00;
RegWrite<=1'b1;
ALUop<=2'b10;
ism<=1'b0;
start<=1'b0;
end

else if (funct7==7'b0000001) begin //M type
jump<=1'b0;
branch<=1'b0;
Resultsrc<=2'b10;
MemWrite<=1'b0;
ALUsrc<=1'b0;
Immsrc<=2'b00;
RegWrite<=1'b1;
ALUop<=2'b10;
ism<=1'b1;
start<=1'b1;
end

end


7'b1100011 : begin  //Branch
jump<=1'b0;
branch<=1'b1;
Resultsrc<=2'b00;
MemWrite<=1'b0;
ALUsrc<=1'b0;
Immsrc<=2'b10;
RegWrite<=1'b0;
ALUop<=2'b01;
ism<=1'b0;
start<=1'b0;
end

7'b0010011 : begin  // I-type arithmetic
jump<=1'b0;
branch<=1'b0;
Resultsrc<=2'b00;
MemWrite<=1'b0;
ALUsrc<=1'b1;
Immsrc<=2'b00;
RegWrite<=1'b1;
ALUop<=2'b11;
ism<=1'b0;
start<=1'b0;
end

7'b1101111 : begin  // J-type
jump<=1'b1;
branch<=1'b0;
Resultsrc<=2'b00;
MemWrite<=1'b0;
ALUsrc<=1'b0;
Immsrc<=2'b11;
RegWrite<=1'b1;
ALUop<=2'b00;
ism<=1'b0;
start<=1'b0;
end

endcase
end

endmodule
