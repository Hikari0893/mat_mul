`include "macro.v"
module full_mult 
(
input [3:0]we, 
input src_clk, rst,
//input state,
input signed [(`WORD_LEN-1):0] data_m1_real,data_m1_imag,data_m2_real,data_m2_imag,   // Necesario para escribir
input[(`ADDR_BITS - 1):0] Dir_M1, Dir_M2,


output signed [((`WORD_LEN)-1):0] coefficient

);

/*INTERNALS*/
wire flag;
wire [(`ADDR_BITS - 1):0] Dir_Matrix_1, Dir_Matrix_2;
wire [(`ADDR_BITS - 1):0] Dir_Mmanager_1, Dir_Mmanager_2;

wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m1;
wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m2;
wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m1;
wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m2;

wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] MX_1;
wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] MX_2;
wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] MY_1;
wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] MY_2;

wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Out_1;
wire signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Out_2;


wire signed [((`WORD_LEN*4)-1):0] sum_0;
wire signed [((`WORD_LEN*4)-1):0] sum_1;

wire signed [((`WORD_LEN*2)-1):0] sum_2;
wire signed [((`WORD_LEN*2)-1):0] sum_3;

wire signed [((`WORD_LEN)-1):0] sum_4;
wire signed [((`WORD_LEN)-1):0] sum_5;


wire we_out0;
wire we_out1;
wire we_out2;
wire we_out3;
wire we_out4;
wire we_out12;
wire we_out13;
wire we_out14;

wire we_out_final;





assign Dir_Matrix_1 = (we == 4'b0000)? Dir_Mmanager_1:Dir_M1;
assign Dir_Matrix_2 = (we == 4'b0000)? Dir_Mmanager_2:Dir_M2;

Mem_Manager DUT 
(
    .clk(src_clk),
    .rst(rst),
    .part_real_done (flag),
	 .we_out(we_out0),
    .Dir_M1(Dir_Mmanager_1),
    .Dir_M2(Dir_Mmanager_2)
);




Q_RAM Q_RAM
(
    .we(we),
	 .we_in(we_out0),
    .clk(src_clk),
    .data_m1_real(data_m1_real), 
    .data_m1_imag(data_m1_imag), 
    .data_m2_real(data_m2_real), 
    .data_m2_imag(data_m2_imag), 


	.we_out(we_out1),
    .Dir_M1(Dir_Matrix_1),  // Necesario para escribir
    .Dir_M2(Dir_Matrix_2), // direccion de memoria
    .Br_m1(Br_m1),
    .Br_m2(Br_m2),
    .Bi_m1(Bi_m1),
    .Bi_m2(Bi_m2) 
);



Block_Select Select

(
    .state (flag),
    .Br_m1 (Br_m1),
    .Br_m2 (Br_m2),
    .Bi_m1 (Bi_m1),
    .Bi_m2 (Bi_m2),

    .MX_1  (MX_1),
    .MX_2  (MX_2),
    .MY_1  (MY_1),
    .MY_2  (MY_2)
 );
 
 

/***********************************************************/
Fxp_Mult Mult_0
(

    .Mult_1 (MX_1),
    .Mult_2 (MX_2),

    .Out_1 (Out_1)
);



Fxp_Mult Mult_1
(

    .Mult_1 (MY_1),
    .Mult_2 (MY_2),

    .Out_1 (Out_2)
);

/**************************************************************************/
pipe_Sum_0  Firstsum_0
(
    .clk (src_clk),
	 .In_1 (Out_1),
	 .we_in(we_out1),

	 .we_out(we_out2),
    .partial_sum_0 (sum_0)
	
);



pipe_Sum_0  Firstsum_1
(
    .clk (src_clk),
	 .In_1 (Out_2),
	 .we_in(we_out1),
	
	 .we_out(we_out12),
    .partial_sum_0 (sum_1)
);

/************************************************************/

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

/************************************************************/
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

/************************************************************/

pipe_Sum_3 Result
( 
	 .clk (src_clk),
	 .we_in1(we_out4),
	 .we_in2(we_out14),
	 .state (flag),
	 .partial_sum_2 (sum_4),
	 .partial_sum_3 (sum_5),
 
    .we_out(we_out_final),
    .result (coefficient)

);
endmodule
