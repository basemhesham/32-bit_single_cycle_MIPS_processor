module Shift_left_twice #(parameter Shift_WIDTH = 32)
(
input   [Shift_WIDTH - 1 : 0]  Shift_IN ,
output  [Shift_WIDTH - 1 : 0]  Shift_OUT
);

assign Shift_OUT = Shift_IN << 2 ;

endmodule