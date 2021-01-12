`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:14:53 07/31/2020 
// Design Name: 
// Module Name:    fifo_write 
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
module fifo_write #(parameter add_size = 3)
						(rstN,w_clk,w_en,w_add);
input w_clk;
input rstN;
input w_en;
output reg [add_size : 0] w_add;

always @(posedge w_clk or negedge rstN)
	begin
		if (!rstN)
			begin
				w_add <=0;
			end
		else 
		if (w_en)
			begin
				w_add <= w_add + 1;
			end
		else
			w_add <= w_add;
	end


endmodule
