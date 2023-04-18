transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/ProyectoFinal/mat_mul {D:/ProyectoFinal/mat_mul/macro.v}
vlog -vlog01compat -work work +incdir+D:/ProyectoFinal/mat_mul {D:/ProyectoFinal/mat_mul/single_port_ram.v}

vlog -vlog01compat -work work +incdir+D:/ProyectoFinal/mat_mul/test {D:/ProyectoFinal/mat_mul/test/ParallelRead_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  ParallelRead_tb

add wave -radix dec -position insertpoint sim:/ParallelRead_tb/j
add wave -radix hex -position insertpoint sim:/ParallelRead_tb/captured_data
add wave -radix hex -position insertpoint sim:/ParallelRead_tb/data
add wave -position insertpoint sim:/ParallelRead_tb/src_clk

add wave -radix hex -label Data0 -position end {Data0 {sim:/ParallelRead_tb/RAM/q[31:0]}}
add wave -radix hex -label Data1 -position end {Data1 {sim:/ParallelRead_tb/RAM/q[63:32]}}
add wave -radix hex -label Data2 -position end {Data2 {sim:/ParallelRead_tb/RAM/q[95:64]}}
add wave -radix hex -label Data3 -position end {Data3 {sim:/ParallelRead_tb/RAM/q[127:96]}}
add wave -radix hex -label Data4 -position end {Data4 {sim:/ParallelRead_tb/RAM/q[159:128]}}
add wave -radix hex -label Data5 -position end {Data5 {sim:/ParallelRead_tb/RAM/q[191:160]}}
add wave -radix hex -label Data6 -position end {Data6 {sim:/ParallelRead_tb/RAM/q[223:192]}}
add wave -radix hex -label Data7 -position end {Data7 {sim:/ParallelRead_tb/RAM/q[255:224]}}


view structure
view signals
run -all
