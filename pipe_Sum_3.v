`include "macro.v"
module pipe_Sum_3
( 
 input clk, we_in1, we_in2, state,
 input signed [((`WORD_LEN)-1):0] partial_sum_2,
 input signed [((`WORD_LEN)-1):0] partial_sum_3,

output reg we_out,
 output signed [((`WORD_LEN)-1):0] result

);
reg signed [`WORD_LEN:0] temp;

always @(posedge clk)
begin 
     if (we_in1 == 1 && we_in2==1)
	      we_out <= 1'b1;
	  else
	      we_out <= 1'b0;
		if (!state)
         temp <= partial_sum_2 - partial_sum_3;
	  else
	      temp <= partial_sum_2 + partial_sum_3;
	  

end

// Hacer truncamiento de la parte fraccionaria
assign result = {temp[32:22],temp[21:1]};

endmodule
