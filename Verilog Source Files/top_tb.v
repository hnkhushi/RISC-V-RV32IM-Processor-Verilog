`timescale 1ns/1ps

module top_tb;

reg clk;
reg rst;


top_module uut (
.clk(clk),
.rst(rst)
);

always #5 clk = ~clk;

initial begin
clk = 0;
rst = 1;


#15;
rst = 0;

#3000;

$finish;


end

endmodule
