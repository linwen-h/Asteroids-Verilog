module ship_controller (
	inout PS2_CLK,
	inout PS2_DAT,
	input clk,
	input [1:0] lives);

	wire shoot, forward, rotate_right, rotate_left, plot_ship;
	reg [3:0] direction;
	reg [7:0] curr_x;
	reg [6:0] curr_y;
	reg [23:0] counter;
	reg [1:0] curr_lives;
	reg [0:0] shooting;
	reg [3:0] past_direction;	
	
	keyboard k0(
		.clk(clk),
		.reset(reset),
		.controller_type(ct),
		.PS2_CLK(PS2_CLK),
		.PS2_DAT(PS2_CLK),
		.shoot(shooting),
		.forward(move),
		.rotate_right(rotate_right),
		.rotate_left(rotate_left),
		);

	spaceship ship(
		.clk(clk), 
		.reset(reset), 
		.start_x(7'd79), 
		.start_y(6'd59), 
		.move_flag(move)
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
				counter <= 24'd10; //TODO: change this time
				move <= 1'b0;
				direction <= 4'b0001;
					
			end
			else begin
				if (!counter) begin
					shooting <= shoot;
					counter <= 24'b10;
					
					if (rotate_right) begin
				
						case (past_direction) //TODO: consider FSA
							0001: direction <= 4'b0101;
							0101: direction <= 4'b0100;
							0100: direction <= 4'b0110;
							0110: direction <= 4'b0010;
							0010: direction <= 4'b1010;
							1010: direction <= 4'b1000;
							1000: direction <= 4'b1001;
							1001: direction <= 4'b0001;
							default: direction <= direction;
	 					endcase
					end 
					else (rotate_left) begin
						case (past_direction)
							0001: direction <= 4'b1001;
							0101: direction <= 4'b1000;
							0100: direction <= 4'b1010;
							0110: direction <= 4'b0010;
							0010: direction <= 4'b0110;
							1010: direction <= 4'b0100;
							1000: direction <= 4'b0101;
							1001: direction <= 4'b0001;
							default: direction <= direction;
	 					endcase						
					end

				else begin
					counter <= counter - 1;	
					past_direction <= direction
								
				end
				
			end
			
		end 
endmodule
