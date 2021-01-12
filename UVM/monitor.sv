import uvm_pkg::*;
`include "uvm_macros.svh"
typedef seq_item;
class monitor extends uvm_monitor;

	uvm_analysis_port #(seq_item) item_collected_port;
	
	virtual inf vif;
	
	seq_item collected_item;
	`uvm_component_utils(monitor)
	
	
	function new (string name,uvm_component parent);
		super.new(name,parent);
		collected_item = new();
		item_collected_port = new("item_collected_port",this); // or inside build_phase
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual inf)::get(this,"","inf",vif))
			//$display("dident get vitual monitor");
			`uvm_fatal(get_type_name(),"dident get vitual driver");
	endfunction
	
	task run_phase(uvm_phase phase);
	forever 
	begin
		//$display("inside monitor run phase");
      `uvm_info(get_type_name(), "Run Phase Called", UVM_MEDIUM);
	//	#1;//monitor run phase run before driver that is why delay is given
		@(vif.monitor_cb);
			if(!vif.monitor_cb.emptyN || !vif.monitor_cb.clrN || !vif.monitor_cb.r_en)
				$display("fifo is empty or clrN or r_en is active");
			else
				begin
					collected_item.dataout = vif.monitor_cb.dataout;
                  	$display("=================write inside monitor =========");
                  	$display("data_out_vif = %h,data_out_sb=%h",vif.monitor_cb.dataout,collected_item.dataout);
                  	item_collected_port.write(collected_item);
				end
				
				
	end
	endtask
	
	
endclass