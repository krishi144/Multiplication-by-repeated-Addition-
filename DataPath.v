`timescale 1ns / 1ps
module mul_datapath(eqz,lda,ldb,ldp,clrp,decb,data_in,clk);
input lda,ldb,ldp,clrp,decb,clk;
input [15:0] data_in;
output eqz;
wire [15:0] x,y,z,bout,bus;
assign bus=data_in; // driving the bus with help of data_in.
pipo1 a (x,bus,lda,clk);
pipo2 p (y,z,ldp,clrp,clk);
cntr b (bout,bus,ldb,decb,clk);
add ad (z,x,y);
eqz comp (eqz,bout);
endmodule
 
`timescale 1ns / 1ps
module add(out,in1,in2);
input [15:0] in1,in2;
output reg [15:0] out;
always@(*)
out=in1+in2;
endmodule

`timescale 1ns / 1ps
module pipo1(dout,din,ld,clk);
input [15:0] din;
input ld,clk;
output reg [15:0] dout;
always @(posedge clk) begin
    if (ld) 
	  dout<=din; 
end
endmodule

`timescale 1ns / 1ps
module pipo2(dout,din,ld,clr,clk);
input [15:0] din;
input ld,clr,clk;
output reg [15:0] dout;
always @(posedge clk) begin
if(clr) dout<=16'b0000_0000_0000_0000;
else if(ld) dout<=din;  
end
endmodule

`timescale 1ns / 1ps
module eqz(eqz,data);
input [15:0] data;
output eqz;
assign eqz=(data==0);
endmodule

`timescale 1ns / 1ps
module cntr(dout,din,ld,dec,clk);
input [15:0] din;
input ld,dec,clk;
output reg [15:0] dout;
always@(posedge clk) begin
if(ld) dout<=din;
else if(dec) dout<=dout-1; 
end
endmodule
