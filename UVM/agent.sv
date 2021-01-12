`include "driver.sv"
`include "monitor.sv"
`include "sequencer.sv"

class agent extends uvm_agent;
	
	driver dr;
	monitor mon;
	sequencer sqr;

	`uvm_component_utils(agent)	
	
	function new (string name, uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		dr    = driver :: type_id :: create("dr",this);
		mon   = monitor :: type_id :: create("mon",this);
		sqr   = sequencer :: type_id :: create("sqr", this);
	endfunction

	function void connect_phase (uvm_phase phase);
		dr.seq_item_port.connect(sqr.seq_item_export);
	endfunction

endclass