
module bullet (clk, load, shooting, reset, firing, direction_x, direction_y, 
		start_x, start_y, collision, curr_x, curr_y, plot_bullet);
	input clk, reset, collision, load, shooting;
	input [7:0] start_x;
	input [6:0] start_y;
	input [1:0] direction_x, direction_y;

	output reg firing, plot_bullet;
	reg [23:0] time_counter;
	reg [1:0] curr_direct_x;
	reg [1:0] curr_direct_y;
	
	output reg [7:0] curr_x;
	output reg [6:0] curr_y;

	always @ (posedge clk)
		begin: draw_move
			if (reset) begin
				firing <= 1'b0; 		
			end
			else begin
				if (collision) begin
					firing <= 1'b0;
					plot_bullet <= 1'b0;
					//TODO: we need to figure out how to make the bullets disappear/end/terminate/kill itself/SIGINT/SIGKILL/-9 			

				end
				else if(shooting)
					firing <= 1'b1;
			end
		end
	//TODO make this work for multiple directions/rotation/8 directions 
	always @(posedge clk)
		begin: timer_count
			if(load) begin
				time_counter <= 24'd10;
				curr_x <= start_x;
				curr_y <= start_y;
				plot_bullet <= 1'b0;
				curr_direct_x <= direction_x;
				curr_direct_y <= direction_y;					
			end
			else begin
				time_counter <= time_counter == 24'd0 ? 24'd10 : time_counter - 1;
				if(time_counter == 24'd0 && firing == 1'b1 && !collision) begin
					plot_bullet <= 1'b1;
					case (curr_direct_x)
						2'b00: curr_x <= curr_x;
						2'b01: curr_x <= curr_x + 1;
						2'b10: curr_x <= curr_x - 1;
						default: curr_x <= curr_x;
					endcase
				
					case (curr_direct_y)
						2'b00: curr_y <= curr_y;
						2'b01: curr_y <= curr_y + 1;
						2'b10: curr_y <= curr_y - 1;
						default: curr_y <= curr_y;	
					endcase
				end
				if (curr_x == 8'd159 || curr_y == 8'd119 || curr_x == 8'd0 || curr_y == 8'd0) begin
					firing <= 1'b0;
					plot_bullet = 1'b0;
				end
	
			end
		end
	
endmodule
