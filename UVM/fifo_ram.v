`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:35:46 07/29/2020 
// Design Name: 
// Module Name:    fifo_ram 
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
module fifo_ram #(parameter width = 8,
						parameter addr = 3)(rstN,data_in,wr_en,clk,wr_add,rd_add,data_out);
parameter depth = (1<<addr);
input rstN;
input [width - 1 : 0] data_in;
input wr_en;
input clk;
input [addr - 1 : 0] wr_add;
input [addr - 1 : 0] rd_add;

output [width -1 : 0] data_out;
reg [width -1 : 0 ] mem [depth - 1 :0];
integer i;

task reset();
	begin
		for (i=0; i<=(depth -1); i=i+1)
			mem[i] <= 0;
	end
endtask


assign data_out = mem[rd_add];

always @(posedge clk or negedge rstN )
	begin 
		if (!rstN)
			begin
				reset();
			end
		else 
		if (wr_en)
			begin
				mem[wr_add] <= data_in;
			end
	end			
				
endmodule
