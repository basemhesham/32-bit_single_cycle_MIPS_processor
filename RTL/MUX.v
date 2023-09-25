
module MUX  #(parameter MUX_SIZE = 32)
(
 input   wire   [MUX_SIZE - 1 : 0]     IN_0,
 input   wire   [MUX_SIZE - 1 : 0]     IN_1,
 input   wire                          SEL,
 output  reg    [MUX_SIZE - 1 : 0]     OUT 
 );

 
  always @ (*)
    begin
     case(SEL)
	  1'b0 :  OUT = IN_0 ;       
	  1'b1 :  OUT = IN_1 ;     		
     endcase        	   
  end
 
 
endmodule
 
