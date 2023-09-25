module ALU #(parameter ALUResult_WIDTH = 32 ,
                       ALUIN_WIDTH   = 32 ,
					             ALUControl_WIDTH = 3  
	        )
(
input          [ALUIN_WIDTH - 1 : 0]         SrcA , SrcB , 
input          [ALUControl_WIDTH - 1 : 0]    ALUControl ,
output reg     [ALUResult_WIDTH - 1 : 0]     ALUResult ,
output reg                                   Zero_flag 
) ;

always @*
begin
 ALUResult = 32'b0 ;
 case (ALUControl)
 3'b000 : ALUResult = SrcA & SrcB ;
 3'b001 : ALUResult = SrcA | SrcB ;
 3'b010 : ALUResult = SrcA + SrcB ;
 3'b100 : ALUResult = SrcA - SrcB ;
 3'b101 : ALUResult = SrcA * SrcB ;
 3'b110 : begin 
           if(SrcA < SrcB)
             ALUResult = 32'b1 ; 
		   else
		     ALUResult = 32'b0 ; 
		  end
		  
default : ALUResult = 32'b0 ;
           
 endcase

end

//zero flag
always @* begin
 Zero_flag = (ALUResult == 32'b0);
end 

endmodule