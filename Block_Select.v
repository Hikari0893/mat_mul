`include "macro.v"


module Block_Select 

(
    input state,
    input [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m1,
    input [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m2,
    input [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m1,
    input [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m2

    output [((`WORD_LEN*`MATRIX_DIM)-1):0] MX_1,
    output [((`WORD_LEN*`MATRIX_DIM)-1):0] MX_2,
    output [((`WORD_LEN*`MATRIX_DIM)-1):0] MY_1,
    output [((`WORD_LEN*`MATRIX_DIM)-1):0] MY_2
);

always @(*) begin

    if state == 'REAL_SET begin
        MX_1 <= Br_m1;
        MX_2 <= Br_m2;
        MY_1 <= Bi_m1;
        MY_2 <= Bi_m2;
    else begin // Imaginay part crossed
        MX_1 <= Br_m1;
        MX_2 <= Bi_m1;
        MY_1 <= Br_m2;
        MY_2 <= Bi_m2;
    end

end


    
end



endmodule
