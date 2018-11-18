vlib work
vlog -timescale 1ns/1ns bullet.v
vsim bullet
log {/*}
add wave {/*}

force {clk} 0 0, 1 10 -r 20
force {reset} 1 0, 0 15
force {direction_x} 2#01 0
force {direction_y} 2#01 0, 2#10 400
force {start_x} 2#01001111
force {start_y} 2#0000011
force {collision} 0


 
run 1500ns
