`include "macro.v"
module Result_memory_wr_tb
(
input [3:0]we, 
input src_clk, rst,
//input state,
input signed [(`WORD_LEN-1):0] data_m1_real,data_m1_imag,data_m2_real,data_m2_imag,   // Necesario para escribir
input[(`ADDR_BITS - 1):0] Dir_M1, Dir_M2,

output we_final,
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
wire we_out0;
wire we_out1;

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

Sum_Block  SUm
(
    .src_clk (src_clk), 
    .we_in (we_out1),
    .PRODUCT_0 (Out_1),
    .PRODUCT_1 (Out_2),
	 .sate (flag),

    .we_out_final (we_final), 
    .MATRIX_COEFFICIENT (coefficient)
);

//RAM Matrix_result
//(
//    .data (coefficient),
//    .addr (Dir_M1),
//    .we   (we),
//    .clk  (src_clk),
//    .q    (C)
//);
//
//
//always @(posedge src_clk) 
//begin
//    if(we_final)
//      we_matrix_result <= 1'b1;
//      
//    
//end


endmodule
 