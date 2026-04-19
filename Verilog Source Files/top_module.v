`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2026 12:37:05 PM
// Design Name: 
// Module Name: top_module
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


module top_module(clk,rst);
input clk,rst;
wire [31:0] pcnext,pcplus4,pctarget,rd1,rd2,bout,rd,mresult;
wire pcsrc,branch,MemWrite,ALUsrc,RegWrite,less,lessu,zero,jump,done,busy,ism,start,start_out,RegWriteEn;
wire [2:0] funct3;
wire [1:0] ALUop,Immsrc,Resultsrc;
wire [3:0] alucontr;
wire [31:0] result,pc,dataout,instr,imout;
//wire [6:0] op;

assign funct3=instr[14:12];
pc_clk p1(clk,rst,pcnext,pc,start_out,busy);
pc_plus4 p2(pc,pcplus4);
pctarget_adder p4(pc,imout,pctarget);
assign pcsrc=   jump | (branch&zero&(funct3==3'b000))|        //BEQ
                (branch&~zero&(funct3==3'b001))|    //BNE
                (branch&less&(funct3==3'b100))|     //BLT
                (branch&~less&(funct3==3'b101))|    //BGE
                (branch&lessu&(funct3==3'b110))|    //BLTU
                (branch&~lessu&(funct3==3'b111));   //BGEU
pc_mux p3(pcsrc,pcplus4,pctarget,pcnext);

instruction_memory i1(pc,instr);

main_decoder md1(instr[6:0],branch,Resultsrc,MemWrite,ALUsrc,Immsrc,RegWrite,ALUop,jump,ism,start,instr[31:25]);
register_file r1(clk,instr[19:15],instr[24:20],instr[11:7],dataout,RegWriteEn,rd1,rd2);
immediate_gen i2(instr,Immsrc,imout);
//assign mresult=32'b0;
assign RegWriteEn = RegWrite & (~ism | done);
b_mux b1(rd2,imout,ALUsrc,bout);
ALU_Controller a1(alucontr, rd1, bout,result,zero);
ALU_Decoder a2(ALUop,instr[14:12],instr[31:25],alucontr);
data_memory d1(clk,rd2,MemWrite,result,rd);
read_mux r2(result,rd,Resultsrc,dataout,mresult);

start_trigger s1(clk,start,start_out,rst,done,busy);
m_unit m1(instr[14:12], rd1, rd2, start_out, done, busy, mresult, rst, clk);
endmodule
