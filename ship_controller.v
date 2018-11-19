module ship_controller (
	inout PS2_CLK,
	inout PS2_DAT,
	input clk,
	input [1:0] lives);

	wire shoot, rotate_right, rotate_left, plot_ship;
	reg [3:0] direction;
	wire [7:0] curr_x;
	wire [6:0] curr_y;
	reg [23:0] counter;
	wire [1:0] curr_lives;
	reg [0:0] shooting;
	reg [3:0] past_direction;
	reg move;
	

	//keyboard k0(
		//.clk(clk),
		//.reset(reset),
		//.controller_type(ct),
		//.PS2_CLK(PS2_CLK),
		//.PS2_DAT(PS2_CLK),
		//.shoot(shooting),
		//.forward(move),
		//.rotate_right(rotate_right),
		//.rotate_left(rotate_left)
		//);

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
				counter <= 24'd10; //TODO: change this time
				move <= 1'b0;
				direction <= 4'b0001;
					
			end
			else begin
				counter <= counter == 24'b0 ? 24'd10: counter - 1;
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
							4'b0101: direction <= 4'b1000;
							4'b0100: direction <= 4'b1010;
							4'b0110: direction <= 4'b0010;
							4'b0010: direction <= 4'b0110;
							4'b1010: direction <= 4'b0100;
							4'b1000: direction <= 4'b0101;
							4'b1001: direction <= 4'b0001;
							default: direction <= direction;
	 					endcase						
					end
				end
				else begin
					past_direction <= direction;		
				end
			end
		end 
endmodule
