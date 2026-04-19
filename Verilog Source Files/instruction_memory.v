`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2026 01:18:58 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(addr,instr);
input [31:0] addr;
output reg [31:0] instr;
reg [31:0] mem[63:0];
initial begin
mem[0]  = 32'h00100093;   // addi x1,x0,1
mem[1]  = 32'h00500113;   // addi x2,x0,5
mem[2]  = 32'h00100193;   // addi x3,x0,1
mem[3]  = 32'h00000213;   // addi x4,x0,0
//loop
mem[4] = 32'h021081B3;   // mul x3,x1,x1
mem[5] = 32'h00320233;   // add x4,x4,x3
mem[6] = 32'h00108093;   // addi x1,x1,1
mem[7] = 32'hFE209AE3;   // bne x2,x1,loop
mem[8] = 32'h0040A023;   //sw x4, 0(x1)
end

always @(*) begin
instr=mem[addr[31:2]];
end

endmodule
