`include "macro.v"
module pipe_Sum_2 
(
input clk, we_in,   
input signed [((`WORD_LEN*2)-1):0] In_3,
output reg we_out,
output signed [((`WORD_LEN)-1):0] partial_sum_2


);

reg signed [((`WORD_LEN)-1):0] buffer_2 [0:1];
reg signed [`WORD_LEN:0] temp;

always @(*)
begin
    buffer_2[0] = In_3[31:0];
    buffer_2[1] = In_3[63:32];
    
end
always @(posedge clk) 
begin
     we_out <= we_in;
    temp <= buffer_2[0] + buffer_2[1];

end   

// Hacer truncamiento de la parte fraccionaria 
assign partial_sum_2 = {temp[32:22], temp[21:1]};

endmodule
