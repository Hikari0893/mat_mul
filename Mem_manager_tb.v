`include "macro.v"
`timescale 10ns / 1ns

module Mem_manager_tb();

    reg clk_tb;
    reg rst_tb;
    wire [(`ADDR_BITS - 1):0] Dir_M1_tb;
    wire [(`ADDR_BITS - 1):0] Dir_M2_tb;

    Mem_Manager DUT (
        .clk(clk_tb),
        .rst(rst_tb),
        .Dir_M1(Dir_M1_tb),
        .Dir_M2(Dir_M2_tb)
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, Dir_M1_tb);
        $dumpvars(1, Dir_M2_tb);

        clk_tb = 0;

        rst_tb = 1;
		  
        #10
        rst_tb = 0;
        #10
        rst_tb = 1;
        #1000;

        // Test case 1
        #100;
        #1000;
        $finish;
    end

    always #5 clk_tb = ~clk_tb;

endmodule

