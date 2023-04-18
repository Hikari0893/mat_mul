module Mem_Manager
(
    input clk,
    input rst,
	output reg [2:0] Dir_M1,
    output reg [6:0] Dir_M2
    
);

reg [6:0] count;

always @(posedge clk or negedge rst) 
begin
    if (!rst) 
    begin
        count = 7'd0;
        Dir_M1 = 3'd0;
    end
    else if (count == 7'd64)
    begin
        count = 7'd0;
        Dir_M2 = 7'd0;
        if (Dir_M1 == 3'd7) 
        begin
            Dir_M1 = 3'd0;
        end 
        else 
        begin
            Dir_M1 = Dir_M1 + 1'd1;
        end
    end 
    else 
    begin
        count = count + 1'd1;
        Dir_M2 = count;
    end
end
  
endmodule 