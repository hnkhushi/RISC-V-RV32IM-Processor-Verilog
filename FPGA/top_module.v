module top_module(clk,rst,led);
input clk,rst;
output [3:0] led;
wire [31:0] result,pc,dataout,instr;
wire MemWrite;
wire [31:0] pcnext,pcplus4,pctarget,rd1,rd2,bout,rd,mresult;
wire pcsrc,branch,ALUsrc,RegWrite,less,lessu,zero,jump,done,busy,ism,start,start_out,RegWriteEn;
wire [2:0] funct3;
wire [1:0] ALUop,Immsrc,Resultsrc;
wire [3:0] alucontr;
wire [31:0] imout;

//wire [6:0] op;
reg [26:0] counter = 0;
reg cpu_enable = 0;

always @(posedge clk) begin
    counter <= counter + 1;

    if (counter == 27'd49_999_999) begin  // adjust based on board clock
        cpu_enable <= 1;
        counter <= 0;
    end else begin
        cpu_enable <= 0;
    end
end

assign funct3=instr[14:12];
pc_clk p1(clk,rst,pcnext,pc,start_out,busy,cpu_enable);
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
register_file r1(clk,instr[19:15],instr[24:20],instr[11:7],dataout,RegWriteEn,rd1,rd2,cpu_enable);
immediate_gen i2(instr,Immsrc,imout);
//assign mresult=32'b0;
assign RegWriteEn = RegWrite & (~ism | done);
b_mux b1(rd2,imout,ALUsrc,bout);
ALU_Controller a1(alucontr, rd1, bout,result,zero,less,lessu);
ALU_Decoder a2(ALUop,instr[14:12],instr[31:25],alucontr);
data_memory d1(clk,rd2,MemWrite,result,rd,cpu_enable);
read_mux r2(result,rd,Resultsrc,dataout,mresult);

start_trigger s1(clk,start,start_out,rst,done,busy,cpu_enable);
m_unit m1(instr[14:12], rd1, rd2, start_out, done, busy, mresult, rst, clk,cpu_enable);
assign led = pc[3:0];
endmodule