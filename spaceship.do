vlib work
vlog -timescale 1ns/1ns spaceship.v
vsim spaceship
log {/*}
add wave {/*}

force {clk} 0 0, 1 10 -r 20
force {reset} 1 0, 0 15, 1 1500, 0 1515
force {start_x} 2#00001111
force {start_y} 2#0000011
force {starting_lives} 2#11
force {shooting} 2#00 0
force {direction_x} 2#01 0
force {direction_y} 2#01 0, 2#10 400
force {collision} 0 0, 1 1000, 0 1005
 
run 1500ns
