module Data_Path 
   #(parameter MIPS_SIZE = 32 , 
			   ALUControl_WIDTH = 3 ,
			   RegAdd_WIDTH = 5  
			 
    )
(
 input                                 CLK , RST ,
 input   [MIPS_SIZE - 1 : 0 ]          ReadData ,
 output  [MIPS_SIZE - 1 : 0 ]          WriteData ,
 output  [MIPS_SIZE - 1 : 0]           PC ,
 input   [MIPS_SIZE - 1 : 0]           instr ,
 output  [MIPS_SIZE - 1 : 0]           ALUResult ,
 output                                Zero_flag ,
 input                                 MemtoReg ,
 input                                 PCSrc ,
 input   [ALUControl_WIDTH - 1 : 0]    ALUControl ,
 input                                 ALUSrc ,
 input                                 RegDst ,
 input                                 RegWrite  ,
 input                                 Jump
  
);

wire  [RegAdd_WIDTH - 1 : 0]   A3_mux ;
wire  [MIPS_SIZE - 1 : 0]      WD3_Result ;
wire  [MIPS_SIZE - 1 : 0]      RD1_SrcA ;
wire  [MIPS_SIZE - 1 : 0]      SrcB_mux ;
wire  [MIPS_SIZE - 1 : 0]      Signlmm ; 
wire  [MIPS_SIZE - 1 : 0]      Signlmm_Shift ; 
wire  [MIPS_SIZE - 1 : 0]      PCPlus4 ;
wire  [MIPS_SIZE - 1 : 0]      PCBranch ;
wire  [MIPS_SIZE - 1 : 0]      Branch_mux ;
wire  [MIPS_SIZE - 1 : 0]      Shift_mux ;
wire  [MIPS_SIZE - 1 : 0]      PC_mux ;

Register_File RegFile (
.CLK(CLK) ,
.RST(RST) ,
.A1(instr[25:21]) ,
.A2(instr[20:16]) ,
.A3(A3_mux) ,
.WE3(RegWrite) ,
.WD3(WD3_Result) ,
.RD1(RD1_SrcA) ,
.RD2(WriteData)
);

MUX #(.MUX_SIZE(5)) MUX_A3 (
.IN_0(instr[20:16]) ,
.IN_1(instr[15:11]) ,
.SEL(RegDst) ,
.OUT(A3_mux)
);

MUX  MUX_Result (
.IN_0(ALUResult) ,
.IN_1(ReadData) ,
.SEL(MemtoReg) ,
.OUT(WD3_Result)
);

Sign_Extend Sign_Extend (
.IN(instr[15:0]) ,
.OUT(Signlmm) 
);

MUX  MUX_SrcB (
.IN_0(WriteData) ,
.IN_1(Signlmm) ,
.SEL(ALUSrc) ,
.OUT(SrcB_mux)
);

ALU ALU1 (
.SrcA(RD1_SrcA) ,
.SrcB(SrcB_mux) ,
.ALUControl(ALUControl) ,
.ALUResult(ALUResult) ,
.Zero_flag(Zero_flag)
);

Shift_left_twice SLT_Signlmm (
.Shift_IN(Signlmm) ,
.Shift_OUT(Signlmm_Shift)
);

Shift_left_twice SLT_PCJump (
.Shift_IN({6'd0 ,instr[25:0] }) ,
.Shift_OUT(Shift_mux)
);

Adder Adder_PCBranch(
.IN_1(Signlmm_Shift) ,
.IN_2(PCPlus4) ,
.OUT(PCBranch)
);

Adder Adder_PCPlus4(
.IN_1(PC) ,
.IN_2(32'd4) ,
.OUT(PCPlus4)
);

MUX MUX_Branch (
.IN_0(PCPlus4) ,
.IN_1(PCBranch) ,
.SEL(PCSrc) ,
.OUT(Branch_mux)
);

MUX MUX_PCJump (
.IN_0(Branch_mux) ,
.IN_1({PCPlus4[31:28],Shift_mux[27:0]}) ,
.SEL(Jump) ,
.OUT(PC_mux)
);

PC PC1 (
.CLK(CLK) ,
.RST(RST) ,
.PC_reg(PC_mux) ,
.PC(PC)
);

endmodule