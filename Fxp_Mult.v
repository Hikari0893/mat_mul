`include "macro.v"

module Fxp_Mult
(

input signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Mult_1,
input signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Mult_2,

output signed [((`WORD_LEN*`MATRIX_DIM)-1):0] Out_1


);

wire signed [(2*(`WORD_LEN*`MATRIX_DIM)-1):0] Prod;
//----------------------------------------------------
assign Prod [63:0]    = Mult_1[31:0]    * Mult_2 [31:0];
assign Prod [127:64]  = Mult_1[63:32]   * Mult_2 [63:32];
assign Prod [191:128] = Mult_1[95:64]   * Mult_2 [95:64];
assign Prod [255:192] = Mult_1[127:96]  * Mult_2 [127:96];
assign Prod [319:256] = Mult_1[159:128] * Mult_2 [159:128];
assign Prod [383:320] = Mult_1[191:160] * Mult_2 [191:160];
assign Prod [447:384] = Mult_1[223:192] * Mult_2 [223:192];
assign Prod [511:448] = Mult_1[255:224] * Mult_2 [255:224];
//------------------------------------------------------


assign Out_1 [31:0]    = {Prod [63:54],Prod[53:32]};
assign Out_1 [63:32]   = {Prod [127:118],Prod[117:96]};
assign Out_1 [95:64]   = {Prod [191:182],Prod[181:160]};
assign Out_1 [127:96]  = {Prod [255:246],Prod[245:224]};
assign Out_1 [159:128] = {Prod [319:310],Prod[309:288]};
assign Out_1 [191:160] = {Prod [383:374],Prod[373:352]};
assign Out_1 [223:192] = {Prod [447:438],Prod[437:416]};
assign Out_1 [255:224] = {Prod [511:502],Prod[501:480]};



endmodule
