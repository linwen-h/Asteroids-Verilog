module ship_controller (
	inout PS2_CLK,
	inout PS2_DAT,
	input CLOCK_50,
	input [2:0] SW, //lives = SW[2:1] reset = SW[0]
	
	output [9:0] LEDR, //[7:4] direction, [3:0] past_direction
	output [6:0] HEX0, //curr_x [3:0]
	output [6:0] HEX1, //curr_x [7:4]
	output [6:0] HEX3, //curr_y [3:0]
	output [6:0] HEX4,  //curr_y [0] + [6:4]
	//output reg [3:0] direction
	
	output			VGA_CLK,   				//	VGA Clock
	output			VGA_HS,					//	VGA H_SYNC
	output			VGA_VS,					//	VGA V_SYNC
	output			VGA_BLANK_N,			//	VGA BLANK
	output			VGA_SYNC_N,				//	VGA SYNC
	output	[9:0]	VGA_R,   				//	VGA Red[9:0]
	output	[9:0]	VGA_G,	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B   				//	VGA Blue[9:0]
	);
	
	wire clk;
	assign clk = CLOCK_50;
	wire lives;
	assign lives = SW[2:1];
	

	//assign LEDR [8:5] = direction;
	//assign LEDR [3:0] = past_direction;
	//assign LEDR[9] = shoot;
	
	hex_seg(HEX0, curr_x[3:0]);
	hex_seg(HEX1, curr_x[7:4]);
	hex_seg(HEX3, curr_y[3:0]);
	hex_seg(HEX4, {1'b0, curr_y[6:4]});
	

	wire shoot, rotate_right, rotate_left, plot_ship;
	reg [3:0] direction;
	wire [7:0] curr_x;
	wire [6:0] curr_y;
	reg [23:0] counter;
	wire [1:0] curr_lives;
	reg [0:0] shooting;
	reg [3:0] past_direction;
	wire move;
	
	wire reset;
	assign reset = SW[0];
	
	wire [23:0] game_clock;
	wire clock_pulse;

	//game_clock(CLOCK_50, 4'd0, reset, 1'b0, 1'b0,game_clock, clock_pulse); 

	keyboard k0(
		.clk(clk),
		.reset(reset),
		.controller_type(1'b1),
		.PS2_CLK(PS2_CLK),
		.PS2_DAT(PS2_DAT),
		.shoot(shoot),
		.forward(move),
		.right_rotate(rotate_right),
		.left_rotate(rotate_left)
		);

	spaceship ship(
		.clk(clk), 
		.reset(reset), 
		.start_x(8'd79), 
		.start_y(7'd59), 
		.move_flag(move),
		.starting_lives(lives), 
		.shooting(shooting), 
		.direction(direction), 
		.collision(1'b0), 
		.curr_x(curr_x), 
		.curr_y(curr_y), 
		.plot_ship(plot_ship), 
		.curr_lives(curr_lives)
		);

		
	always @ (posedge clk)
		begin
			if (reset) begin
				counter <= 24'd12500000; //TODO: change this time (1/4 second)
				//move <= 1'b0;
				direction <= 4'b0001;
					
			end
			else begin
				counter <= counter == 24'b0 ? 24'd12500000: counter - 1;
				if (counter == 24'd0) begin
				shooting <= 1'b0; //TODO
				if (rotate_right && rotate_left) begin
					direction <= direction;
				end
				else if (rotate_right) begin // TODO: Left and Right click at the same time
					case (past_direction) //TODO: consider FSA
							4'b0001: direction <= 4'b0101;
							4'b0101: direction <= 4'b0100;
							4'b0100: direction <= 4'b0110;
							4'b0110: direction <= 4'b0010;
							4'b0010: direction <= 4'b1010;
							4'b1010: direction <= 4'b1000;
							4'b1000: direction <= 4'b1001;
							4'b1001: direction <= 4'b0001;
							default: direction <= direction;
	 				endcase
				end 
				else if (rotate_left) begin
					case (past_direction)
							4'b0001: direction <= 4'b1001;
							4'b0101: direction <= 4'b0001;
							4'b0100: direction <= 4'b0101;
							4'b0110: direction <= 4'b0100;
							4'b0010: direction <= 4'b0110;
							4'b1010: direction <= 4'b0010;
							4'b1000: direction <= 4'b1010;
							4'b1001: direction <= 4'b1000;
							default: direction <= direction;
	 				endcase						
				end
				end
					past_direction <= direction;		
			end
		end 


	wire [7:0] moving_asteroids;
	wire [63:0] asteroid_x_coords;
	wire [55:0] asteroid_y_coords;
	wire [7:0] asteroid_collisions;
	
	assign LEDR[0] = clock_pulse;
	assign LEDR[9:1] = moving_asteroids;
	
	asteroid_generator generator(
					.game_clk(clk),
					.reset(reset),
					.moving_block(moving_asteroids),
					.x_coords(asteroid_x_coords),
    				.y_coords(asteroid_y_coords),
					.spaceship_collisions(asteroid_collisions)
					);

    //output [9:0] LEDR //[7:4] direction, [3:0] past_direction
	  //output [6:0] HEX0, //curr_x [3:0]
	  //output [6:0] HEX1, //curr_x [7:4]
	  //output [6:0] HEX3, //curr_y [3:0]
	  //output [6:0] HEX4  //curr_y [0] + [6:4]
    
	
	//this module generates the graphics
	graphics graphics_module(
				.CLOCK_50(clk), 
				.KEY(reset), 
				.asteroid_x(asteroid_x_coords), 
				.asteroid_y(asteroid_y_coords), 
				.draw_asteroid(moving_asteroids),
				.ship_direction(direction), 
				.VGA_CLK(VGA_CLK), 
				.VGA_HS(VGA_HS),						
				.VGA_VS(VGA_VS),
				.VGA_BLANK_N(VGA_BLANK_N), 
				.VGA_SYNC_N(VGA_SYNC_N), 
				.VGA_R(VGA_R), 
				.VGA_G(VGA_G),
				.VGA_B(VGA_B)
				);
endmodule