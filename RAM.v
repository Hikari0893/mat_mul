// Quartus Prime Verilog Template
// Single port RAM with single read/write address 
`include "macro.v"
module RAM 
#(parameter DATA_WIDTH=`WORD_LEN, parameter ADDR_WIDTH=`ADDR_M)
(
	input signed [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input we, clk,
	output signed [(DATA_WIDTH - 1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[(`ADDR_M-1):0];

	
	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data;

		
	end

				ram[addr_reg+7]};

endmodule
