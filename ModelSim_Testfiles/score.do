vlib work
vlog -timescale 1ns/1ns score.v
vsim score
 
log {/*}
add wave {/*}

force {clk} 0 0, 1 10 -r 20
force {reset} 1 0, 0 15
force {hit} 0 0, 1 9, 0 11 -r 20
run 10000 ns


