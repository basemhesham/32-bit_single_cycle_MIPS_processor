module PC #(parameter PC_WIDTH = 32)
(
input                          CLK ,RST,
input      [PC_WIDTH - 1 : 0]   PC_reg ,
output reg [PC_WIDTH - 1 : 0]   PC 
);

always @( posedge CLK or negedge RST )
begin
if (!RST)
  PC <= 32'b0 ;
else 
  PC <= PC_reg ;
end

endmodule