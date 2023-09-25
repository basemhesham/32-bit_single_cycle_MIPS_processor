module Sign_Extend #(parameter DATA_IN = 16 , DATA_OUT = 32 )
(
 input   [DATA_IN  - 1 : 0]  IN ,
 output  [DATA_OUT - 1 : 0]  OUT 
);

assign OUT = { {DATA_IN{IN[DATA_IN-1]} } , IN } ;  
   //assign OUT =  { { 16 {1'b1} } ,Instr };
endmodule