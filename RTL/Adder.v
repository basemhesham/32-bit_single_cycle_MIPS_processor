module Adder #(parameter ADDER_WIDTH = 32)
(
input  [ADDER_WIDTH - 1 : 0] IN_1 , IN_2 ,
output [ADDER_WIDTH - 1 : 0] OUT  
);
assign OUT = IN_1 + IN_2 ;

endmodule