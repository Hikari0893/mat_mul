`include "macro.v"

module Mem_Manager
(
    input clk,
    input rst,
	 output reg part_real_done,
    output reg we_out,
    output reg [(`ADDR_BITS - 1):0] Dir_M1,
    output reg [(`ADDR_BITS - 1):0] Dir_M2
    
);

reg [(`ADDR_BITS - 1):0] count;
reg [(`ADDR_BITS - 1):0] slowcount;
initial we_out =1'b0;
initial part_real_done = `REAL_SET;
always @(posedge clk or negedge rst) 
begin
    if (!rst) 
    begin
        we_out = 1'b1;
        count     = 7'd0;
        slowcount = 7'd0;
        Dir_M1    = 7'd0;
        Dir_M2    = 7'd0;
		  part_real_done = `REAL_SET;
    end
    else if (count == 7'd56)
    begin
        count  = 7'd0;
        Dir_M2 = 7'd0;
        //slow
        if (slowcount == 7'd56) 
        begin
            slowcount = 7'd0;
            Dir_M1    = 7'd0;
				//part_real_done = `IMAG_SET;
            part_real_done = 1^part_real_done; // toggle 
								

        end
        else 
        begin
            slowcount = slowcount + 7'd8;
            Dir_M1    = slowcount;
				//part_real_done = `REAL_SET;
        end
    end 
    else 
    begin
        count  = count + 7'd8;
        Dir_M2 = count;
    end
end
  
endmodule 