`include "env.sv"
`include "seq.sv"

class test extends uvm_test;

	`uvm_component_utils(test);
	
	
	env e;
	seq sq;
	
	
	function new (string name = "test",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		e = env :: type_id :: create ("e",this);
	endfunction
	
	function void end_of_elaboration_phase (uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		`uvm_info(get_type_name(), "EOE PHASE", UVM_MEDIUM);
		print();
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		sq = seq :: type_id :: create("sq",this);
		//sq.randomize;
		sq.start(e.ag.sqr);
		phase.drop_objection(this);
	endtask
	

endclass