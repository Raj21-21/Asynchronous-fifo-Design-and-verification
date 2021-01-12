`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:38 07/31/2020 
// Design Name: 
// Module Name:    fifo_read 
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
module fifo_read#(parameter add_size = 3)
						(rstN,r_clk,r_add,r_en);
input r_clk;
input rstN;
input r_en;
output reg [add_size : 0] r_add;

always @(posedge r_clk or negedge rstN)
	begin
		if (!rstN)
			begin
				r_add <=0;
			end
		else 
		if (r_en)
			begin
				r_add <= r_add + 1;
			end
		else
			r_add <= r_add;
	end
endmodule
