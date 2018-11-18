module spaceship(clk, reset, start_x, start_y, starting_lives shooting, direction_x, direction_y, collision, curr_x, curr_y, plot_ship, curr_lives);

input clk, reset, shooting, collision;
input [7:0] start_x;
input [6:0] start_y;
input [1:0] starting_lives;

output reg [7:0] curr_x;
output reg [6:0] curr_y;
output reg [1:0] curr_lives;

reg [23:0] time_counter;
reg plot_ship;

bullet_maker buller_factory(
			.clk(clk), 
			.pressed(shooting), 
			.reset(reset), 
			.direct_x(direction_x), 
			.direct_y(direction_y), 
			.ship_x(curr_x), 
			.ship_y(curr_y));

always @ (posedge clk)
begin: timer_block
	if (reset) begin
		time_counter <= 24'd8333333; //TODO: change the time here
		curr_x <= start_x;
		curr_y <= start_y;
		curr_lives <= starting_lives;
	end
	else begin
		time_counter <= time_counter == 24'd0 ? 24'd10 : time_counter - 1;				
		if(time_counter == 24'd0 && !collison) begin
			plot_ship <= 1'b1;
			case (direction_x)
				2'b00: curr_x <= curr_x;
				2'b01: curr_x <= curr_x + 1;
				2'b10: curr_x <= curr_x - 1;
				default: curr_x <= curr_x;
			endcase
				
			case (direction_y)
				2'b00: curr_y <= curr_y;
				2'b01: curr_y <= curr_y + 1;
				2'b10: curr_y <= curr_y - 1;
				default: curr_y <= curr_y;	
			endcase

			case (curr_x)
				8'd159: curr_x <= 8'd0;
				8'd0: curr_x <= 8'd159;
				default: curr_x <= curr_x;	
			endcase
				7'd119: curr_y <= 7'd0;
				7'd0: curr_y <= 7'd119;
				default: curr_y <= curr_y
			case (curr_y)
				

			endcase		
		end
		else if (collision) begin
			plot_ship = 1'b0;
			curr_lives <= curr_lives - 1;
			curr_x <= start_x;
			curr_y <= start_y;		
		end
	end //TODO: make sure to load directions in correctly in top module that deals with key presses
end

	



endmodule
