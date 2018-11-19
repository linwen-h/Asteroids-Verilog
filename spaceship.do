vlib work
vlog -timescale 1ns/1ns spaceship.v
vsim spaceship
log {/*}
add wave {/*}

force {clk} 0 0, 1 10 -r 20
force {reset} 1 0, 0 15, 1 1500, 0 1515
force {start_x} 2#00001111
force {start_y} 2#0000011
force {move_flag} 1 0, 0 350 , 1 700
force {starting_lives} 2#11
force {shooting} 2#00 0
force {direction} 2#0101 0, 0110 700
force {collision} 0 0, 1 1300, 0 1315
 
run 1400ns
