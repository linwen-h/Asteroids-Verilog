vlib work
vlog -timescale 1ns/1ns asteroid.v
vsim asteroid
 
log {/*}
add wave {/*}

force {clk} 0 0, 1 10 -r 20
force {reset} 0 0, 1 5, 0 11
force {collision} 0 0
force {start} 1
force {direct} 2#0010

run 2000ns
