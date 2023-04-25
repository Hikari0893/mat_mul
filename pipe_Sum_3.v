`include "macro.v"
module pipe_Sum_3
( 
 input clk,
 input signed [((`WORD_LEN)-1):0] partial_sum_2,
 input signed [((`WORD_LEN)-1):0] partial_sum_3,

 output signed [((`WORD_LEN)-1):0] result

);
reg signed [`WORD_LEN:0] temp;

always @(posedge clk)
begin 
    temp <= partial_sum_2 - partial_sum_3;

end

// Hacer truncamiento de la parte fraccionaria
assign result = {temp[32:22],temp[21:1]};

endmodule
