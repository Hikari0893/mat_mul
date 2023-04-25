`include "macro.v"

module Mem_Manager
(
    input clk,
    input rst,
	output reg [(`ADDR_BITS - 1):0] Dir_M1,
    output reg [(`ADDR_BITS - 1):0] Dir_M2
    
);

reg [(`ADDR_BITS - 1):0] count;
reg [(`ADDR_BITS - 1):0] slowcount;

always @(posedge clk or negedge rst) 
begin
    if (!rst) 
    begin
        count     = 7'd0;
        slowcount = 7'd0;
        Dir_M1    = 7'd0;
        Dir_M2    = 7'd0;
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

        end
        else 
        begin
            slowcount = slowcount + 7'd8;
            Dir_M1    = slowcount;
        end
    end 
    else 
    begin
        count  = count + 7'd8;
        Dir_M2 = count;
    end
end
  
endmodule 