`timescale 10ns / 1ns

module Mem_manager_tb();

    reg clk_tb;
    reg rst_tb;
    wire [2:0] Dir_M1_tb;
    wire [6:0] Dir_M2_tb;

    Mem_Manager DUT (
        .clk(clk_tb),
        .rst(rst_tb),
        .Dir_M1(Dir_M1_tb),
        .Dir_M2(Dir_M2_tb)
    );

    initial begin
        clk_tb = 0;

        rst_tb = 1;
		  
        #10
        rst_tb = 0;
        #10
        rst_tb = 1;

        // Test case 1
        #100;
        if (Dir_M1_tb !== 3'b000 || Dir_M2_tb !== 7'b000000)
            $display("Test case 1 failed!");

        // Test case 2
        #1000;
        if (Dir_M1_tb !== 3'b001 || Dir_M2_tb !== 7'b000001)
            $display("Test case 2 failed!");

        // Test case 3
        #1000;
        if (Dir_M1_tb !== 3'b010 || Dir_M2_tb !== 7'b000010)
            $display("Test case 3 failed!");

        // Test case 4
        #1000;
        if (Dir_M1_tb !== 3'b011 || Dir_M2_tb !== 7'b000011)
            $display("Test case 4 failed!");

        // Test case 5
        #1000;
        if (Dir_M1_tb !== 3'b100 || Dir_M2_tb !== 7'b000100)
            $display("Test case 5 failed!");

        // Test case 6
        #1000;
        if (Dir_M1_tb !== 3'b101 || Dir_M2_tb !== 7'b000101)
            $display("Test case 6 failed!");

        // Test case 7
        #1000;
        if (Dir_M1_tb !== 3'b110 || Dir_M2_tb !== 7'b000110)
            $display("Test case 7 failed!");

        // Test case 8
        #1000;
        if (Dir_M1_tb !== 3'b111 || Dir_M2_tb !== 7'b000111)
            $display("Test case 8 failed!");

        // Test case 9
        #1000;
        if (Dir_M1_tb !== 3'b000 || Dir_M2_tb !== 7'b001000)
            $display("Test case 9 failed!");

        // Test case 10
        #1000;
        if (Dir_M1_tb !== 3'b001 || Dir_M2_tb !== 7'b001001)
            $display("Test case 10 failed!");

        $display("Testbench finished");
        $finish;
    end

    always #5 clk_tb = ~clk_tb;

endmodule
