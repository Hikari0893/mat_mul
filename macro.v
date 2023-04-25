// Define a macro `power_of_two` that takes an input `x` and returns the value of 2 raised to the power of `x`
// This is achieved by performing a left shift operation on the binary value of 1 by `x` places
// which effectively multiplies it by 2^x.
//`define power_of_two(x) (1<<2)
`define REAL_SET 1'b0
`define IMAG_SET 1'b1
//First fxd_point analysis
`define Int_part  5
`define Frac_part 27

// Define a macro `WORD_LEN` and set it to 32
`define WORD_LEN 32//`power_of_two(5)

// Define a macro `ADDR_BITS` and set it to 7
`define ADDR_BITS  7
`define ADDR_M  6 // final matrix

// Define a macro `MATRIX_DIM` and set it to 8 by calling the `power_of_two` macro with an input of 3
`define MATRIX_DIM  8//`power_of_two(3)

`define NULL 0

