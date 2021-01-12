`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:37:43 07/29/2020 
// Design Name: 
// Module Name:    fifo_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`include "fifo_ram.v"
`include "fifo_write.v"
`include "fifo_read.v"
module fifo_top #(parameter width = 8,
						parameter add_width = 4)(f_in,clrN,W_EN,R_EN,w_clk,r_clk,f_out,fullN,emptyN);
// write input signals output 
input w_clk;
input W_EN;

wire [add_width :0] w_add; //output of write module
wire  w_en;
//read input signal and output

input r_clk;
input R_EN;

wire r_en;
wire [add_width :0]  r_add;  //output of read  module 

//memory input and output 
input [width - 1:0] f_in; 
input clrN;

output [width -1:0] f_out;
output emptyN;
output fullN;

assign w_en = fullN && W_EN ;
assign r_en = emptyN && R_EN;
assign fullN  = !((w_add[add_width] != r_add[add_width])&& (w_add[add_width - 1:0] == r_add[add_width -1:0]));
assign emptyN = !((w_add[add_width] == r_add[add_width])&& (w_add[add_width - 1:0] == r_add[add_width -1:0]));


fifo_ram #(width,add_width) RAM (.rstN(clrN),
								 .data_in(f_in),
								 .wr_en(w_en),
								 .clk(w_clk),
								 .wr_add(w_add[add_width-1:0]),
								 .rd_add(r_add[add_width-1:0]),
								 .data_out(f_out)
								);
											 
fifo_write #(add_width) write   (.rstN(clrN),
								 .w_clk(w_clk),
								 //.w_rstN(w_rstN),
								 .w_en(w_en),
								 .w_add(w_add)
								);
										 
fifo_read #(add_width) read     (.rstN(clrN),
								 .r_clk(r_clk),
								// .r_rstN(r_rstN),
								 .r_en(r_en),
								 .r_add(r_add)
								);
endmodule

