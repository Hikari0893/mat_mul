`include "../macro.v"

module Q_RAM 
(
    input we, clk,
    input [(`WORD_LEN-1):0] data_m1,data_m2,
    input [(`ADDR_BITS - 1):0] Dir_M1, Dir_M2,

    output [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m1,
    output [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m2,
    output [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m1,
    output [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m2


);

single_port_ram M1_Real
(
    .data (data_m1),
    .addr (Dir_M1),
    .we   (we),
    .clk  (clk),
    .q    (Br_m1)
);

single_port_ram M1_Imag
(
    .data (data_m1),
    .addr (Dir_M1),
    .we   (we),
    .clk  (clk),
    .q    (Bi_m1)
);

single_port_ram M2_Real
(
    .data (data_m2),
    .addr (Dir_M2),
    .we   (we),
    .clk  (clk),
    .q    (Br_m2)
);

single_port_ram M2_Imag
(
    .data (data_m2),
    .addr (Dir_M2),
    .we   (we),
    .clk  (clk),
    .q    (Bi_m2)
);


endmodule
