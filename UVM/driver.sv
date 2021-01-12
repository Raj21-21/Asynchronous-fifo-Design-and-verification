typedef seq_item;
class driver extends uvm_driver #(seq_item);

	virtual inf vif;
	`uvm_component_utils(driver)
	uvm_analysis_port #(seq_item) item_collected_port;
	
	function new (string name, uvm_component parent);
		super.new(name,parent);
		item_collected_port = new("item_collected_port",this);
	endfunction
	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual inf)::get(this,"","inf",vif))
			//$display("dident get vitual driver");
			`uvm_fatal(get_type_name(),"dident get vitual driver");
	endfunction
	
	
	task run_phase (uvm_phase phase);
		@(vif.driver_cb);
					vif.driver_cb.clrN   <= 0;
					vif.driver_cb.w_en <= 0;
					vif.driver_cb.r_en <= 0;
		forever begin
          @(vif.driver_cb);
         // if (vif.driver_cb.fullN)
            begin
				seq_item_port.get_next_item(req); // check we need to declare seq_item type handle 
				if (vif.driver_cb.fullN)
					begin
						req.print();
						drive(); //pass using seq_item hendle or not
					end
			else
				$display("==========fifo is full at time = %0d ns ================",$time);
			seq_item_port.item_done();
            end
 
            

		end
	endtask
	
	task drive();
		//$display("driver drive task");
      `uvm_info(get_type_name(), "Run Phase Called", UVM_MEDIUM);//doesnt support in modelsim
		
			//if ( req.clrN && req.w_en)
				begin
					vif.driver_cb.datain <= req.datain;
					vif.driver_cb.clrN   <= req.clrN;
					vif.driver_cb.w_en <= req.w_en;
					vif.driver_cb.r_en <= req.r_en;
                  $display("======== time  t data is written in vif = %0d ns ===========",$time);
				  item_collected_port.write(req);
				  $display("======== time  t data is written in dr to sb = %0d ns ===========",$time);
                end
		/*	else
				begin
                  	vif.driver_cb.datain <= 8'b0;
					vif.driver_cb.clrN   <= req.clrN;
					vif.driver_cb.w_en <= req.w_en;
					vif.driver_cb.r_en <= req.r_en;
                  $display("============fifo rst is activated ============");
                  $display("clrN =%0b ,w_en = %0b",req.clrN, req.w_en);
				end*/
	endtask
	
endclass