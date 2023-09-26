module Register_File #(parameter RegAdd_WIDTH = 5 , RegFile_WIDTH = 32 , RegFile_DEPTH = 32)
(
 input                                  CLK ,RST ,
 input                                  WE3 ,
 input      [RegAdd_WIDTH - 1 : 0]      A1 , A2 , A3 ,
 input      [RegFile_WIDTH - 1 : 0]     WD3 ,
 output reg [RegFile_WIDTH - 1 : 0]     RD1 ,RD2
);

reg [RegFile_WIDTH - 1 : 0] RegFile [RegFile_DEPTH - 1 : 0] ;
integer I ;
  
  //written synchronously
always @(posedge CLK or negedge RST)
begin
if(!RST)   
    begin
      for (I = 0 ; I < RegFile_DEPTH ; I = I +1)
        begin
          RegFile[I] <= {RegFile_WIDTH{1'b0}}; 
        end
     end
	 
else if (WE3) 
   RegFile[A3] <= WD3 ;
  
end 

//read asynchronously
always @*
begin
   RD1 = RegFile[A1] ;
   RD2 = RegFile[A2] ;
end

endmodule
