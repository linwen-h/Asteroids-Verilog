vlib work
vlog -timescale 1ns/1ns ship_controller.v
vsim ship_controller
log {/*}
add wave {/*}

force {clk} 0 0, 1 10 -r 20
force {reset} 1 0, 0 15, 1 1500, 0 1515
force {move} 1 0, 0 350 , 1 700
force {lives} 2#11
force {shoot} 2#00 0
force {rotate_right} 0 0, 1 400, 0 625
force {rotate_left} 0 0
 
run 1700ns
