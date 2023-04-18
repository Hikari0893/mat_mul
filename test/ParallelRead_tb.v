`include "../macro.v"
`timescale 10ns /1ns



module ParallelRead_tb();

reg [(`WORD_LEN-1):0] data;
reg [(`ADDR_BITS-1):0] addr;
reg we;
reg src_clk;
wire [((`WORD_LEN*`MATRIX_DIM)-1):0] q;

initial src_clk = 0;

single_port_ram RAM
(
    .data (data),
    .addr (addr),
    .we   (we),
    .clk  (src_clk),
    .q    (q)
);


integer fd_A; // file handler
integer scan_file; // file handler
integer i;
integer j;
reg [(`WORD_LEN-1):0] captured_data;

initial begin

    //write memory
    //src_clk = 1'b0;
    #10
    fd_A    = $fopen("matrixA.csv", "r");
    if (fd_A == 0) 
    begin
        $display("data_file handle was NULL");
        $finish;
    end

    we = 1'b1; // write enable
    // intial memory address
    addr = 7'h00;
    
    for(i = 0;i < 1;i=i+1) 
    begin
        scan_file = $fscanf(fd_A, "%s\n", captured_data);//float line

        // Read real part
        for (j = 0; j < 64; j = j + 1) begin
            scan_file = $fscanf(fd_A, "%X,", captured_data);//row number
            // Do something with each item in captured_data
            $display("captured_data[%d] = %X", j, captured_data);
            #3
            data = captured_data;
            #2
            addr = addr+1;
            #10;
        end
        /*
        // Read imaginary part
        for (j = 64; j < 128; j = j + 1) begin
            scan_file = $fscanf(fd_A, "%X,", captured_data);//row number
            // Do something with each item in captured_data
            $display("captured_data[%d] = %X", j, captured_data[j]);
            #3
            data = captured_data[j];
            #2
            addr    = addr+1;
            #10;
        end
        */
    end
    // start reading sequence
    we = 1'b0;
    addr = 7'h00;
    #100;
    $fclose(fd_A);
    // parallel read testing
    $stop;
end



always #1 src_clk=~src_clk;

endmodule