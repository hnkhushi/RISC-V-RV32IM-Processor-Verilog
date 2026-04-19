`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2026 05:49:00 PM
// Design Name: 
// Module Name: ALU_Decoder
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


module ALU_Decoder(aluop,funct3,funct7,alucontr);
input [1:0] aluop;
input [2:0] funct3;
input [6:0] funct7;
output reg [3:0] alucontr;

always@(*) begin
case(aluop)
2'b00: alucontr=4'b0000;
2'b01: case(funct3)         //Branch
        3'b000: alucontr=4'b0001; //BEQ
        3'b001: alucontr=4'b0001;   //BNE
        default : alucontr=4'b0000;
        endcase
2'b10: case(funct3)         // R-Type I-type
        3'b000: if (funct7[5]) alucontr=4'b0001; //SUB
                else alucontr=4'b0000;      //ADD
        3'b001: alucontr=4'b0101;           //SLL
        3'b010: alucontr=4'b0100;           //SLT
        3'b011: alucontr=4'b1001;           //SLTU
        3'b100: alucontr=4'b0111;           //XOR
        3'b101: if (funct7[5]) alucontr=4'b1000;    //SRA
                else alucontr=4'b0110;              //SRL
        3'b110: alucontr=4'b0011;                   //OR
        3'b111: alucontr=4'b0010;                   //AND
        default: alucontr=4'b0000;
        endcase
2'b11 : case(funct3)
        3'b000: alucontr=4'b0000;           //ADDI
        3'b001: alucontr=4'b0101;           //SLLI
        3'b010: alucontr=4'b0100;           //SLTI
        3'b011: alucontr=4'b1001;           //SLTUI
        3'b100: alucontr=4'b0111;           //XORI
        3'b101: if (funct7[5]) alucontr=4'b1000;    //SRAI
                else alucontr=4'b0110;              //SRLI
        3'b110: alucontr=4'b0011;                   //ORI
        3'b111: alucontr=4'b0010;                   //ANDI
        endcase
        
default: alucontr=4'b0000;
endcase
end
        
endmodule
