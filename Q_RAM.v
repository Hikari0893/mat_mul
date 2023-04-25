`include "macro.v"

module Q_RAM 
(
    input [3:0]we, 
    input clk,
    input signed [(`WORD_LEN-1):0] data_m1_real,data_m1_imag,data_m2_real,data_m2_imag,   // Necesario para escribir
    input  [(`ADDR_BITS - 1):0] Dir_M1, Dir_M2, // direccion de memoria
    output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m1,
    output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m2,
    output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m1,
    output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m2

);


single_port_ram M1_Real
(
    .data (data_m1_real),
    .addr (Dir_M1),
    .we   (we[0]),
    .clk  (clk),
    .q    (Br_m1)
);

single_port_ram M2_Real
(
    .data (data_m2_real),
    .addr (Dir_M2),
    .we   (we[1]),
    .clk  (clk),
    .q    (Br_m2)
);

single_port_ram M1_Imag
(
    .data (data_m1_imag),
    .addr (Dir_M1),
    .we   (we[2]),
    .clk  (clk),
    .q    (Bi_m1)
);


single_port_ram M2_Imag
(
    .data (data_m2_imag),
    .addr (Dir_M2),
    .we   (we[3]),
    .clk  (clk),
    .q    (Bi_m2)
);




endmodule
