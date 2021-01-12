import uvm_pkg::*;
`include "uvm_macros.svh"

module top;

	
	`include "fifo_top.v"
	`include "interface.sv"
	`include "test.sv"
	
	
	bit w_clk;
	bit r_clk;
	
	always #5  w_clk <= ~w_clk;
	always #10 r_clk <= ~r_clk;
	
	inf intf(w_clk,r_clk);
	
	fifo_top DUT (	.f_in	(intf.datain),
					.clrN	(intf.clrN),
					.W_EN	(intf.w_en),
					.R_EN	(intf.r_en),
					.w_clk	(intf.w_clk),
					.r_clk	(intf.r_clk),
					.f_out	(intf.dataout),
					.fullN	(intf.fullN),
					.emptyN	(intf.emptyN)
					);
					
	initial begin
			uvm_config_db #(virtual inf)::set(null,"*","inf",intf);
			$dumpfile("dump.vcd");
			$dumpvars;
	end
	
	initial begin
		run_test("test");
	end
	
endmodule