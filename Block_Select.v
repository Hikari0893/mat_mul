`include "macro.v"


module Block_Select 

(
    input state,
    input signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m1,
    input signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m2,
    input signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m1,
    input signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m2,

    output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] MX_1,
    output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] MX_2,
    output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] MY_1,
    output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] MY_2
);

assign MX_1 = Br_m1;
assign MX_2 = (state==`REAL_SET)? Br_m2:Bi_m2;  //MX_1* MX_2
assign MY_1 = Bi_m1;                            //MY_1*MY_2 
assign MY_2 = (state==`REAL_SET)? Bi_m2:Br_m2;
    
endmodule
