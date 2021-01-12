import uvm_pkg::*;
`include "uvm_macros.svh"
typedef seq_item;
class scoreboard extends uvm_scoreboard;
	
	`uvm_component_utils(scoreboard);
  `uvm_analysis_imp_decl(_monitor_1)
  `uvm_analysis_imp_decl(_driver_2)
  
  uvm_analysis_imp_monitor_1 #(seq_item , scoreboard) monitor_1;
  uvm_analysis_imp_driver_2 #(seq_item , scoreboard) driver_2;
	
	bit [7:0] q[$];
	int pass=0;
	int fail=0;
	function new (string name = "scoreboard",uvm_component parent);
		super.new(name,parent);
      	monitor_1 = new ("monitor_1",this);
      	driver_2 = new ("driver_2",this);
	endfunction
  

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
	endfunction

	function void write_monitor_1 (seq_item moni_pkt);
		$display("=================write monitor inside scoreboard=========");
		$display($time,"data_out = %d",moni_pkt.dataout);
		$display($time,"queue_data = %p",q);
		if (moni_pkt.dataout==q.pop_front())
			begin
				`uvm_info("MYINFO1_pass", $sformatf("number of pass: %0d", pass++), UVM_LOW);
			end
		else
			begin
				`uvm_error("ERROR", "This is an error")
				`uvm_info("MYINFO1_fail", $sformatf("number of pass: %0d", fail++), UVM_LOW);
			end
			
	endfunction
  
  function void write_driver_2(seq_item driv_pkt);
    	$display("=================write driver inside scoreboard=========");
		if ( driv_pkt.clrN && driv_pkt.w_en)
			begin
				$display("data_in = %d",driv_pkt.datain); 
				q.push_back(driv_pkt.datain);
			end
		else if (!driv_pkt.clrN)
				q.delete();
		else
			;
			
	endfunction

endclass