import uvm_pkg::*;
`include "uvm_macros.svh"
typedef seq_item;
class seq extends uvm_sequence #(seq_item);
	int x;
	seq_item pkt;
	`uvm_object_utils(seq)
	
	
	//-------------------------------------
	//constructor 
	//-------------------------------------
	
	function new (string name = "seq");
		super.new(name);
	endfunction
	
	virtual task pre_body();
			$display("SEQ Inside pre_body of sequence");
		//`uvm_info("SEQ","Inside pre_body of sequence",UVM_MEDIUM);
	endtask
	
	 task body ();
		repeat (150)
			begin
				x += 1;
				$display("======================start seqncer====================");
				$display("iteration = %d",x);
				pkt = seq_item::type_id::create("pkt");
				start_item(pkt);
				assert(pkt.randomize());
				finish_item(pkt);
				$display("======================end seqncer====================");
			end
	endtask
	
endclass

/*  req = mem_seq_item::type_id::create("req");  //create the req (seq item)
    wait_for_grant();                            //wait for grant
    assert(req.randomize());                     //randomize the req                   
    send_request(req);                           //send req to driver
    wait_for_item_done();                        //wait for item done from driver
    get_response(rsp);                           //get response from driver
	*/