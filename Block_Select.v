`include "../macro.v"


module Block_Select 

(
    input clk,
    input [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m1,
    input [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m2,
    input [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m1,
    input [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m2,

    output [31:0] Block_0,
    output [31:0] Block_1,
    output [31:0] Block_2,
    output [31:0] Block_3
);

// Estados de la FSM
    localparam [1:0] REAL = 2'b00, IMAG = 2'b01;

//Señales de estado y de salida
    reg [1:0] actual_state, next_state; 
    reg [63:0] M1_M2_Real_siguiente, M1_M2_Imag_siguiente;    


//Lógica del estado siguiente 
always @(*)
begin




end    

//Lógica de salida
 always @(posedge clk) 
 begin 





 end


endmodule
