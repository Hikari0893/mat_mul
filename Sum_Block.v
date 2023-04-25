`include "macro.v"
module Sum_Block
(
input src_clk, we_in, state,
input signed [((`WORD_LEN*`MATRIX_DIM)-1):0] PRODUCT_0,
input signed [((`WORD_LEN*`MATRIX_DIM)-1):0] PRODUCT_1,

output we_out_final, 
output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] MATRIX_COEFFICIENT

);


// INTERNALS

wire we_out0;
wire we_out1;
wire we_out2;
wire we_out3;
wire we_out4;
wire we_out12;
wire we_out13;
wire we_out14;

wire signed [((`WORD_LEN*4)-1):0] sum_0;
wire signed [((`WORD_LEN*4)-1):0] sum_1;

wire signed [((`WORD_LEN*2)-1):0] sum_2;
wire signed [((`WORD_LEN*2)-1):0] sum_3;

wire signed [((`WORD_LEN)-1):0] sum_4;
wire signed [((`WORD_LEN)-1):0] sum_5;


pipe_Sum_0  Firstsum_0
(
    .clk (src_clk),
    .In_1 (PRODUCT_0),
    .we_in(we_out1),

    .we_out(we_out2),
    .partial_sum_0 (sum_0)
);


pipe_Sum_0  Firstsum_1
(
    .clk (src_clk),
    .In_1 (PRODUCT_1),
    .we_in(we_out1),
	
    .we_out(we_out12),
    .partial_sum_0 (sum_1)
);


pipe_Sum_1 Secondsum_0
(
    .clk (src_clk),
    .In_2 (sum_0),
    .we_in(we_out2),
	 
    .we_out(we_out3),
    .partial_sum_1 (sum_2)
);


pipe_Sum_1 Secondsum_1
(
    .clk  (src_clk),
    .In_2 (sum_1),
    .we_in(we_out12),
	 
    .we_out (we_out13),
    .partial_sum_1 (sum_3)
);
pipe_Sum_2 Thirdsum_0
(
    .clk (src_clk),    
    .In_3 (sum_2),
    .we_in(we_out3),
	 
    .we_out(we_out4),
    .partial_sum_2 (sum_4)
);


pipe_Sum_2 Thirdsum_1
(
    .clk (src_clk),    
    .In_3 (sum_3),
    .we_in(we_out13),

    .we_out (we_out14),
    .partial_sum_2 (sum_5)
);
pipe_Sum_3 Result
( 
    .clk (src_clk),
    .we_in1(we_out4),
    .we_in2(we_out14),
	 .state(sate),
    .partial_sum_2 (sum_4),
    .partial_sum_3 (sum_5),
 
    .we_out(we_out_final),
    .result (MATRIX_COEFFICIENT)

);

endmodule
