
`timescale 1ns/1ps


module MIPS_TB();

/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter MIPS_SIZE = 32 ;      
parameter CLK_PERIOD = 50 ; 


/////////////////////////////////////////////////////////
//////////////////// DUT Signals ////////////////////////
/////////////////////////////////////////////////////////
reg                  		CLK_TB;
reg                  		RST_TB;
wire   [(MIPS_SIZE/2)-1:0]  test_value_TB ;


////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial
 begin

 // Initialization
 initialize() ;

 // Reset
 reset() ; 

 ////////////// Test Case 1 //////////////////

 
  #(20*CLK_PERIOD);

$stop ;

end
 
 

///////////////////// Clock Generator //////////////////

always #(CLK_PERIOD/2) CLK_TB = ~CLK_TB ;

////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////

task initialize ;
  begin
	CLK_TB            = 1'b0   ;
	RST_TB            = 1'b1   ;    // rst is deactivated
  end
endtask



task reset ;
  begin
	#(CLK_PERIOD)
	RST_TB  = 1'b0;           // rst is activated
	#(CLK_PERIOD)
	RST_TB  = 1'b1;
	#(CLK_PERIOD) ;
  end
endtask

///////////////// Design Instaniation //////////////////
MIPS DUT (
.CLK(CLK_TB),
.RST(RST_TB),
.test_value(test_value_TB)
);

endmodule