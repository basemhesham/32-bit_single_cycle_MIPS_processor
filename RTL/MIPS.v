module MIPS 

#( parameter    MIPS_SIZE = 32 , 
			    ALUControl_WIDTH = 3 	 
)            

(
input  wire                           CLK ,
input  wire                           RST ,
output wire [(MIPS_SIZE/2)-1:0]    test_value
);

// internal connection
 wire                                 Zero_flag ;
 wire                                 MemtoReg ;
 wire                                 PCSrc ;
 wire   [ALUControl_WIDTH - 1 : 0]    ALUControl ;
 wire                                 ALUSrc ;
 wire                                 RegDst ;
 wire                                 RegWrite  ;
 wire                                 Jump ;
 wire                                 MemWrite ;
 wire   [MIPS_SIZE - 1 : 0 ]          ReadData ;
 wire   [MIPS_SIZE - 1 : 0 ]          WriteData ;
 wire   [MIPS_SIZE - 1 : 0]           PC ;
 wire   [MIPS_SIZE - 1 : 0]           instr ;
 wire   [MIPS_SIZE - 1 : 0]           ALUOut ;
 
Data_Path DP (
.CLK(CLK) ,
.RST(RST) ,
.ReadData(ReadData) ,
.WriteData(WriteData) ,
.PC(PC) ,
.instr(instr) ,
.ALUResult(ALUOut) ,
.Zero_flag(Zero_flag) ,
.MemtoReg(MemtoReg) ,
.PCSrc(PCSrc) ,
.ALUControl(ALUControl) ,
.ALUSrc(ALUSrc) ,
.RegDst(RegDst) ,
.RegWrite(RegWrite) ,
.Jump(Jump) 
);

Control_Unit CU (
.OpCode(instr[31:26]) ,
.Funct(instr[5:0]) ,
.Zero_flag(Zero_flag) ,
.MemtoReg(MemtoReg) ,
.MemWrite(MemWrite) ,
.PCSrc(PCSrc) ,
.ALUControl(ALUControl) ,
.ALUSrc(ALUSrc) ,
.RegDst(RegDst) ,
.RegWrite(RegWrite)  ,
.Jump(Jump)
);


Instruction_Memory IM (
.PC(PC) ,
.RD(instr)
);

Data_Memory DM (
.CLK(CLK) ,
.RST(RST) ,
.WE(MemWrite) ,
.A(ALUOut) ,
.WD(WriteData) ,
.RD(ReadData) ,
.test_value(test_value)
);
endmodule