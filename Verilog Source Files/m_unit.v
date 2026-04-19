`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2026 06:14:30 PM
// Design Name: 
// Module Name: m_unit
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


module m_unit(funct3, a, b, start, done, busy, result, reset, clk);

input [2:0]  funct3;
input start, reset, clk;
input [31:0] a, b;

output reg done, busy;
output reg [31:0] result;


parameter IDLE     = 3'b000;
parameter DECODE   = 3'b001;
parameter EXEC_MUL = 3'b010;
parameter EXEC_DIV = 3'b011;
parameter FINISH   = 3'b100;


parameter MUL  = 3'b000;
parameter MULH = 3'b001;   
parameter DIV  = 3'b100;
parameter DIVU = 3'b101;
parameter REM  = 3'b110;
parameter REMU = 3'b111;


reg [31:0] regA, regB, absA, absB;
reg [31:0] multiplier, multiplicand;
reg [31:0] divisor, dividend, quotient;
reg Asign, Bsign, sign_mul, sign_div, sign_rem;
reg [32:0] remainder;          
reg [32:0] temp;              
reg [63:0] product;
reg [5:0]  count;
reg [2:0]  op_type;            
reg [2:0]  curr_st, next_st;


always @(posedge clk) begin

    if (reset) begin
        curr_st <= IDLE;
        busy    <= 1'b0;
        done    <= 1'b0;
        result  <= 32'b0;

        next_st <= IDLE;
    end
    else begin

        curr_st <= next_st;

        next_st <= next_st;  
        busy    <= 1'b1;

        case (next_st)   


            IDLE: begin
                busy <= 1'b0;
                done <= 1'b0;
                if (start) next_st <= DECODE;
                else        next_st <= IDLE;
            end


            DECODE: begin
                regA  <= a;
                regB  <= b;
                Asign <= a[31];
                Bsign <= b[31];

                absA  <= a[31] ? (~a + 1) : a;
                absB  <= b[31] ? (~b + 1) : b;

                op_type <= funct3;   

                case (funct3)

                    MUL: begin
                        multiplicand <= a[31] ? (~a + 1) : a;
                        multiplier   <= b[31] ? (~b + 1) : b;
                        sign_mul     <= a[31] ^ b[31];
                        product      <= 64'b0;
                        count        <= 6'd32;
                        busy         <= 1'b1;
                        next_st      <= EXEC_MUL;
                    end

                    default: begin   
    
                        if (funct3 == DIVU || funct3 == REMU) begin
                            dividend <= a;
                            divisor  <= b;
                        end else begin
                            dividend <= a[31] ? (~a + 1) : a;
                            divisor  <= b[31] ? (~b + 1) : b;
                        end
                        quotient  <= 32'b0;
                        remainder <= 33'b0;
                        count     <= 6'd32;
                        sign_div  <= a[31] ^ b[31];
                        sign_rem  <= a[31];
                        busy      <= 1'b1;
                        next_st   <= EXEC_DIV;
                    end

                endcase
            end


            EXEC_MUL: begin
                if (count > 0) begin
                    if (multiplier[0]) product <= product + {32'b0, multiplicand};
                    multiplicand <= multiplicand << 1;
                    multiplier   <= multiplier  >> 1;
                    count        <= count - 1;
                    next_st      <= EXEC_MUL;
                end
                else begin

                    if (sign_mul) result <= (~product[31:0] + 1);
                    else          result <=   product[31:0];
                    next_st <= FINISH;
                end
            end


            EXEC_DIV: begin
                if (count > 0) begin
 
                    temp = {remainder[31:0], dividend[31]};   
                    dividend <= dividend << 1;

                    if (temp >= {1'b0, divisor}) begin
                        remainder <= temp - {1'b0, divisor};
                        quotient  <= (quotient << 1) | 32'd1;
                    end
                    else begin
                        remainder <= temp;
                        quotient  <= (quotient << 1);
                    end

                    count   <= count - 1;
                    next_st <= EXEC_DIV;
                end
                else begin
    
                    case (op_type)
                        DIV:  begin
                                  if (sign_div) result <= (~quotient + 1);
                                  else          result <=   quotient;
                              end
                        DIVU: result <= quotient;
                        REM:  begin
                                  if (sign_rem) result <= (~remainder[31:0] + 1);
                                  else          result <=   remainder[31:0];
                              end
                        REMU: result <= remainder[31:0];
                        default: result <= 32'b0;
                    endcase
                    next_st <= FINISH;
                end
            end


            FINISH: begin
                busy    <= 1'b0;
                done    <= 1'b1;
                next_st <= IDLE;
            end

            default: next_st <= IDLE;

        endcase
    end 
end 

endmodule

