`include "macro.v"
module Result_tb();

reg [3:0]we;
reg src_clk, rst;

reg [(`ADDR_BITS - 1):0] Dir_M1, Dir_M2; // direccion de memoria
reg signed[(`WORD_LEN-1):0] data_m1_real,data_m1_imag,data_m2_real,data_m2_imag;   // Necesario para escribir

wire we_final;
wire signed [((`WORD_LEN)-1):0] coefficient;


initial src_clk = 0;
initial rst = 1;


Result_memory_wr_tb  TEST
(
    .we (we), 
    .src_clk (src_clk), 
    .rst (rst),

    .data_m1_real (data_m1_real),
    .data_m1_imag (data_m1_imag),
    .data_m2_real (data_m2_real),
    .data_m2_imag (data_m2_imag),   // Necesario para escribir
    .Dir_M1 (Dir_M1), 
    .Dir_M2 (Dir_M2),

    .we_final (we_final),
    .coefficient (coefficient)
);

/************************
MEMORY HANDLER
*************************/
integer fd_A; // file handler
integer fd_B; // file handler
integer scan_file; // file handler
integer i;
integer j;
reg signed[(`WORD_LEN-1):0] captured_data_0;
reg signed[(`WORD_LEN-1):0] captured_data_1;
reg signed[(`WORD_LEN-1):0] captured_data_2;
reg signed[(`WORD_LEN-1):0] captured_data_3;

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


    we = 4'b0000; // write disable
    // intial memory address
    Dir_M1 = 7'h00;
    
    for(i = 0;i < 1;i=i+1) //! Realizacion
    begin

        we = 4'b0001; // REAL MATRIX enable
        /***************************************
        ************ MATRIX A *******************
        *****************************************/
        //RESET THE ADDRES FOR WRITE
        Dir_M1 = 0;

        scan_file = $fscanf(fd_A, "%s\n", captured_data_0);//float line
        // Read real part
        for (j = 0; j < 64; j = j + 1) begin
            scan_file = $fscanf(fd_A, "%X,", captured_data_0);//row number
            // Do something with each item in captured_data
            $display("captured_data_0[%d] = %X", j, captured_data_0);
            #3
            data_m1_real = captured_data_0; //! REAL
            #2
            Dir_M1 = Dir_M1+1;
            #10;
        end

        #10
        we = 4'b0100; // IMAG MATRIX enable

        //RESET THE ADDRES FOR WRITE
        Dir_M1 = 7'h00;

        // Read imaginary part
        for (j = 0; j < 64; j = j + 1) begin
            scan_file = $fscanf(fd_A, "%X,", captured_data_1);//row number
            // Do something with each item in captured_data
            $display("captured_data_1[%d] = %X", j+64, captured_data_1);
            #3
            data_m1_imag = captured_data_1; //! IMAG
            #2
            Dir_M1    = Dir_M1+1;
            #10;
        end

        #10
        we = 4'b0010; // REAL MATRIX enable

        /***************************************
        ************ MATRIX B *******************
        *****************************************/
        Dir_M2 = 0;
        scan_file = $fscanf(fd_B, "%s\n", captured_data_2);//float line
        // Read real part
        for (j = 0; j < 64; j = j + 1) begin
            scan_file = $fscanf(fd_B, "%X,", captured_data_2);//row number
            // Do something with each item in captured_data
            $display("captured_data_2[%d] = %X", j, captured_data_2);
            #3
            data_m2_real = captured_data_2; //! REAL
            #2
            Dir_M2 = Dir_M2+1;
            #10;
        end

        #10
        we = 4'b1000; // REAL MATRIX enable

        
        //RESET THE ADDRES FOR WRITE
        Dir_M2 = 0;

        // Read imaginary part
        for (j = 64; j < 128; j = j + 1) begin
            scan_file = $fscanf(fd_B, "%X,", captured_data_3);//row number
            // Do something with each item in captured_data
            $display("captured_data[%d] = %X", j, captured_data_3);
            #3
            data_m2_imag = captured_data_3; //! IMAG
            #2
            Dir_M2    = Dir_M2+1;
            #10;
        end
        
    end
    #100
    // start reading sequence
    we = 4'b0000;
	 rst = 1;
	 //state = `REAL_SET;
		  
    #10
    rst = 0;
    #10
    rst = 1;
	 
	 
	 //state = `IMAG_SET;
	 
	 
    //#10;
    //Dir_M1 = 7'h00;
    //Dir_M2 = 7'h00;
    #10000
	 
	 
	 
	 
	 
    $stop;

	$fclose(fd_A);
	$fclose(fd_B);
    // parallel read testing
    $stop;
end



always #1 src_clk=~src_clk;

endmodule

