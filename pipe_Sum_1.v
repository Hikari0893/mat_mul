`include "macro.v"
module pipe_Sum_1
(
input clk, we_in,
input signed [((`WORD_LEN*4)-1):0] In_2,

output reg we_out,
output signed [((`WORD_LEN*2)-1):0] partial_sum_1

);

reg signed [(`WORD_LEN-1):0] buffer_1 [0:((`MATRIX_DIM/2) - 1)];
reg signed [`WORD_LEN:0] suma_acumulada_1 [0:((`MATRIX_DIM/4) - 1)];



always @(*)
begin
    buffer_1[0] = In_2 [31:0];
    buffer_1[1] = In_2 [63:32];
    buffer_1[2] = In_2 [95:64];
    buffer_1[3] = In_2 [127:96];
    
end
always @(posedge clk) 
begin
         we_out <= we_in;
        suma_acumulada_1[0] <= buffer_1[0] + buffer_1[1];
    
        suma_acumulada_1[1] <= buffer_1[2] + buffer_1[3];
    
end

// Hacer truncamiento de la parte fraccionaria
assign partial_sum_1[31:0]  = {suma_acumulada_1[0][32:22], suma_acumulada_1[0][21:1]};
assign partial_sum_1[63:32] = {suma_acumulada_1[1][32:22], suma_acumulada_1[1][21:1]};

endmodule





