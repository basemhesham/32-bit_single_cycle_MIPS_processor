module Data_Memory #(parameter DataMemory_WIDTH = 32 , DataMemory_DEPTH = 256 )
(
input                                       CLK,RST,
input                                        WE ,
input      [ DataMemory_WIDTH - 1 : 0 ]      A ,
input      [ DataMemory_WIDTH - 1 : 0 ]      WD ,
output reg [ DataMemory_WIDTH - 1 : 0 ]      RD , 
output reg [(DataMemory_WIDTH/2) - 1 : 0]    test_value
);

reg [DataMemory_WIDTH - 1 : 0] Data_mem [DataMemory_DEPTH - 1  : 0] ;
integer I ;

 always @(posedge CLK or negedge RST )
 begin
  if(!RST)   
    begin
      for (I = 0 ; I < DataMemory_DEPTH ; I = I +1)
        begin
          Data_mem[I] <= {DataMemory_WIDTH{1'b0}}; 
        end
     end
 else if (WE)
     Data_mem [A] <= WD ;
 end
 
 always @*
  begin
   RD = Data_mem [A] ;
   test_value = Data_mem[32'b0] ;
 end
endmodule