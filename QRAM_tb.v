`include "macro.v"
`timescale 10ns /1ns



module QRAM_tb();

// Entradas
reg [(`ADDR_BITS - 1):0] Dir_M1, Dir_M2; // direccion de memoria
reg we;
reg src_clk;
reg [(`WORD_LEN-1):0] data_m1_real,data_m1_imag,data_m2_real,data_m2_imag; // Necesario para escribir 

// SALIDAS
wire [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m1;
wire [((`WORD_LEN*`MATRIX_DIM)-1):0] Br_m2;
wire [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m1;
wire [((`WORD_LEN*`MATRIX_DIM)-1):0] Bi_m2;

initial src_clk = 0;


Q_RAM Q_RAM
(
    .we(we),
    .clk(src_clk),
    .data_m1_real(data_m1_real), 
    .data_m1_imag(data_m1_imag), 
    .data_m2_real(data_m2_real), 
    .data_m2_imag(data_m2_imag),    // Necesario para escribir
    .Dir_M1(Dir_M1), 
    .Dir_M2(Dir_M2), // direccion de memoria
    .Br_m1(Br_m1),
    .Br_m2(Br_m2),
    .Bi_m1(Bi_m1),
    .Bi_m2(Bi_m2) 
);

/************************
MEMORY HANDLER
*************************/
integer fd_A; // file handler
integer fd_B; // file handler
integer scan_file; // file handler
integer i;
integer j;
reg [(`WORD_LEN-1):0] captured_data;

initial begin

    //write memory
    #10
    fd_A    = $fopen("matrixA.csv", "r");
    fd_B    = $fopen("matrixB.csv", "r");

    if (fd_A == 0) 
    begin
        $display("data_file A handle was NULL");
        $finish;
    end

    if (fd_B == 0) 
    begin
        $display("data_file B handle was NULL");
        $finish;
    end


    we = 1'b1; // write enable
    // intial memory address
    Dir_M1 = 7'h00;
    
    for(i = 0;i < 1;i=i+1) //! Realizacion
    begin

        /***************************************
        ************ MATRIX A *******************
        *****************************************/
        //RESET THE ADDRES FOR WRITE
        Dir_M1 = 0;

        scan_file = $fscanf(fd_A, "%s\n", captured_data);//float line
        // Read real part
        for (j = 0; j < 64; j = j + 1) begin
            scan_file = $fscanf(fd_A, "%X,", captured_data);//row number
            // Do something with each item in captured_data
            $display("captured_data[%d] = %X", j, captured_data);
            #3
            data_m1_real = captured_data; //! REAL
            #2
            Dir_M1 = Dir_M1+1;
            #10;
        end

        //RESET THE ADDRES FOR WRITE
        Dir_M1 = 0;

        // Read imaginary part
        for (j = 64; j < 128; j = j + 1) begin
            scan_file = $fscanf(fd_A, "%X,", captured_data);//row number
            // Do something with each item in captured_data
            $display("captured_data[%d] = %X", j, captured_data);
            #3
            data_m1_imag = captured_data; //! IMAG
            #2
            Dir_M1    = Dir_M1+1;
            #10;
        end

        /***************************************
        ************ MATRIX B *******************
        *****************************************/
        Dir_M2 = 0;
        scan_file = $fscanf(fd_B, "%s\n", captured_data);//float line
        // Read real part
        for (j = 0; j < 64; j = j + 1) begin
            scan_file = $fscanf(fd_B, "%X,", captured_data);//row number
            // Do something with each item in captured_data
            $display("captured_data[%d] = %X", j, captured_data);
            #3
            data_m2_real = captured_data; //! REAL
            #2
            Dir_M2 = Dir_M2+1;
            #10;
        end

        //RESET THE ADDRES FOR WRITE
        Dir_M2 = 0;

        // Read imaginary part
        for (j = 64; j < 128; j = j + 1) begin
            scan_file = $fscanf(fd_B, "%X,", captured_data);//row number
            // Do something with each item in captured_data
            $display("captured_data[%d] = %X", j, captured_data);
            #3
            data_m2_imag = captured_data; //! IMAG
            #2
            Dir_M2    = Dir_M2+1;
            #10;
        end
    end
    $fclose(fd_A);


    // start reading sequence
    we     = 1'b0;
    Dir_M1 = 7'h00;
    Dir_M2 = 7'h00;
	 
	 	 
    #10000;
	 $fclose(fd_A);
	 $fclose(fd_B);
    // parallel read testing
    $stop;
end



always #1 src_clk=~src_clk;

endmodule