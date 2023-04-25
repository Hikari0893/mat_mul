`include "macro.v"
module pipe_Sum_0 
(
input clk,
input signed [((`WORD_LEN*`MATRIX_DIM)-1):0] In_1,


output signed [((4*`WORD_LEN) - 1):0] partial_sum_0


);

reg signed[(`WORD_LEN-1):0] buffer [0:(`MATRIX_DIM - 1)];
reg signed [`WORD_LEN:0] suma_acumulada [0:3];//((`MATRIX_DIM/2) - 1)




always @(*)
begin
    buffer[0] = In_1 [31:0];
    buffer[1] = In_1 [63:32];
    buffer[2] = In_1 [95:64];
    buffer[3] = In_1 [127:96];
    buffer[4] = In_1 [159:128];
    buffer[5] = In_1 [191:160];
    buffer[6] = In_1 [223:192];
    buffer[7] = In_1 [255:224];
end
always @(posedge clk) 
begin
     	  
   
        suma_acumulada[0] <= buffer[0] + buffer[1];
		       
        suma_acumulada[1] <= buffer[2] + buffer[3];
    
        suma_acumulada[2] <= buffer[4] + buffer[5];
    
        suma_acumulada[3] <= buffer[6] + buffer[7];
    

end

// Hacer truncamiento de la parte fraccionaria

assign partial_sum_0 [31:0]   = {suma_acumulada[0][32:22],suma_acumulada[0][21:1]};
assign partial_sum_0 [63:32]  = {suma_acumulada[1][32:22],suma_acumulada[1][21:1]};
assign partial_sum_0 [95:64]  = {suma_acumulada[2][32:22],suma_acumulada[2][21:1]};
assign partial_sum_0 [127:96] = {suma_acumulada[3][32:22],suma_acumulada[3][21:1]};                        


endmodule







