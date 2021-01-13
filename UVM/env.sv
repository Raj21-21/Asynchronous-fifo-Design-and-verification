
`include "agent.sv"
`include "scoreboard.sv"

class env extends uvm_env;

	agent ag;
	scoreboard sb;
	
	`uvm_component_utils(env)
	
	function new (string name, uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
	
		ag = agent :: type_id :: create ("ag",this);
		sb = scoreboard :: type_id :: create ("sb",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		ag.mon.item_collected_port.connect(sb.monitor_1);
      	ag.dr.item_collected_port.connect(sb.driver_2); //  used driver to write data into scorboard
	endfunction

endclass