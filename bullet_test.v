module bullet_test(
	input CLOCK_50,
	input [9:0] SW,
	
	
	output [9:0] LEDR, //LEDR [1] = plot bullet, [0] = firing
	output [6:0] HEX0, //curr_x [3:0]
	output [6:0] HEX1, //curr_x [7:4]
	output [6:0] HEX3, //curr_y [3:0]
	output [6:0] HEX4  //curr_y [0] + [6:4]
	);
	
	wire [7:0] curr_x; 
	wire [6:0] curr_y;
	
	hex_seg(HEX0, curr_x[3:0]);
	hex_seg(HEX1, curr_x[7:4]);
	hex_seg(HEX3, curr_y[3:0]);
	hex_seg(HEX4, {1'b0, curr_y[6:4]});
	
	
	
	bullet b0 (
		.clk(CLOCK_50),
		.load(SW[1]),
		.shooting(SW[6]),
		.reset(SW[0]),
		.firing(LEDR[0]),
		.direction_x(SW[3:2]),
		.direction_y(SW[5:4]),
		.start_x(8'd79),
		.start_y(7'd59),
		.collision(1'b0),
		.curr_x(curr_x),
		.curr_y(curr_y),
		.plot_bullet(LEDR[1])
	);

	
endmodule