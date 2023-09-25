module Control_Unit #(parameter OpCode_WIDTH = 6 ,Funct_Width = 6 , ALUControl_WIDTH = 3 , ALUOp_WIDTH = 2)
(
 input       [OpCode_WIDTH - 1 : 0]         OpCode ,
 input       [Funct_Width  - 1 : 0]          Funct ,
 input                                       Zero_flag ,
 output  reg                                 MemtoReg ,
 output  reg                                 MemWrite ,
 output  reg                                 PCSrc ,
 output  reg [ALUControl_WIDTH - 1 : 0]      ALUControl ,
 output  reg                                 ALUSrc ,
 output  reg                                 RegDst ,
 output  reg                                 RegWrite  ,
 output  reg                                 Jump
); 
  reg [ALUOp_WIDTH - 1 : 0] ALUOp ;
  reg Branch ;
  always @*
  begin
    Jump     = 1'b0 ;
    ALUOp    = 2'b00 ;
    MemWrite = 1'b0 ;
    RegWrite = 1'b0 ;
    RegDst   = 1'b0 ;
    ALUSrc   = 1'b0 ;
    MemtoReg = 1'b0 ;
    Branch   = 1'b0 ;

    // Main Decoder 
    case (OpCode) 
      6'b10_0011 : begin     //load
        RegWrite = 1'b1 ;
        ALUSrc   = 1'b1 ;
        MemtoReg = 1'b1 ;
      end

      6'b10_1011 : begin   //store
        MemWrite = 1'b1 ;
        ALUSrc   = 1'b1 ;
        MemtoReg = 1'b1 ;
      end

      6'b00_0000 : begin   //R Type
        ALUOp    = 2'b10 ;
        RegWrite = 1'b1 ;
        RegDst   = 1'b1 ;
      end

      6'b00_1000 : begin   //addi
        RegWrite = 1'b1 ;
        ALUSrc   = 1'b1 ;
      end

      6'b00_0100 : begin     //branch if equal
        ALUOp  = 2'b01 ;
        Branch = 1'b1 ;
      end

      6'b00_0010 : begin     //jump
        Jump     = 1'b1 ;
      end

      default : begin    
        Jump     = 1'b0 ;
        ALUOp    = 2'b00 ;
        MemWrite = 1'b0 ;
        RegWrite = 1'b0 ;
        RegDst   = 1'b0 ;
        ALUSrc   = 1'b0 ;
        MemtoReg = 1'b0 ;
        Branch   = 1'b0 ;
      end
    endcase 
  end

  always @*
  begin
    case(ALUOp)
      2'b00 : ALUControl = 3'b010 ;
      2'b01 : ALUControl = 3'b100 ;
      2'b10 : begin 
        case (Funct)
          6'b10_0000 : ALUControl = 3'b010;
          6'b10_0010 : ALUControl = 3'b100;
          6'b10_1010 : ALUControl = 3'b110;
          6'b01_1100 : ALUControl = 3'b101; 
          default :    ALUControl = 3'b010;
        endcase 
      end
      default: ALUControl = 3'b010;
    endcase
  end

always @* begin
 PCSrc = Branch & Zero_flag ;
end
  
endmodule