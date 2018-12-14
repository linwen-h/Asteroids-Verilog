vlib work
vlog -timescale 1ns/1ns random_generator.v
vsim lfsr
 
log {/*}
add wave {/*}

force {clk} 0 0, 1 10 -r 20
force {rst_n} 0 0, 1 5, 0  11
run 1000ns


