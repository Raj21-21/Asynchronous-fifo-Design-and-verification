
interface inf #(int size = 8)(input bit w_clk,input bit r_clk);

//---------------------------------------
  //declaring the signals
  //---------------------------------------
	logic [size-1 : 0] datain;
	logic r_en,w_en,clrN;
	logic fullN;
	logic emptyN;
	logic [size-1 : 0] dataout;
  //---------------------------------------
  //driver clocking block
  //---------------------------------------
  
  clocking driver_cb @ (posedge w_clk);
	default input #1 output #1;
	output datain;
	output w_en;
	output clrN;
	output r_en;
	input fullN;
	input emptyN;
  endclocking
  //---------------------------------------
  //monitor clocking block
  //---------------------------------------
  
  clocking monitor_cb @ (posedge r_clk);
	default input #1 output #1;
	input datain;
	input w_en;
	input clrN;
	input r_en;
	input fullN;
	input emptyN;
	input dataout;
  endclocking
  
 /* clocking monitor_cb_w_clk @ (posedge w_clk);
	default input #1 output #1;
	input datain;
	input w_en;
	input clrN;
	input r_en;
	input fullN;
	input emptyN;
	input dataout;
  endclocking
  */
 // modport DRIVER  (clocking driver_cb,input w_clk);
 // modport MONITOR (clocking monitor_cb,input r_clk);
  
  
 endinterface