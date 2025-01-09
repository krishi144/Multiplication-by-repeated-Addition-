`timescale 1ns / 1ps
module testbench;
reg [15:0] data_in;
reg clk,start;
wire done;
mul_datapath dp (eqz,lda,ldb,ldp,clrp,decb,data_in,clk);
controller con (lda,ldb,ldp,clrp,decb,done,clk,eqz,start);

initial begin 
 clk=1'b0;
 #3 start=1'b1;
 #500 $finish;
 end

always #5 clk=~clk;

initial begin 
#17 data_in=17;
#10 data_in=5;
end
initial begin
$monitor ($time," %d %b",dp.y,done);
$dumpfile("mul.vcd");
$dumpvars(0,testbench);
end
endmodule 
