
import uvm_pkg::*;
`include "uvm_macros.svh"
class seq_item extends uvm_sequence_item;

 //---------------------------------------
  //data and control fields
  //---------------------------------------
rand bit [7:0]datain;
rand bit clrN;
rand bit w_en,r_en;
     bit [7:0]dataout;
	 bit fullN,emptyN;


//	`uvm_object_utils(seq_item);
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(seq_item)
	`uvm_field_int(datain,UVM_ALL_ON)
	`uvm_field_int(clrN,UVM_ALL_ON)
	`uvm_field_int(w_en,UVM_ALL_ON)
	`uvm_field_int(r_en,UVM_ALL_ON)
  `uvm_object_utils_end
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  
  function new(string name = "seq_item");
	super.new(name);
  endfunction
  
  //------------------------------------------
  // add some constraints 
  //------------------------------------------
  
  constraint c1 { 	if (w_en)
						datain inside{[1:255]};
					else
						datain == 0;}
  
 
	constraint c2 {clrN == 1;} 			//because of this it went to infinite read 	
					
	constraint c3 {w_en dist{0:=1,1:=100};} 
	constraint c4 {r_en dist{0:=1,1:=100};} 
					
  
endclass