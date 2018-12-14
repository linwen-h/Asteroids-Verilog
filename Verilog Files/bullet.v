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


	always @(posedge clk)
		begin: timer_count
			
		
			if (reset) begin
				firing <= 1'b0; 
						
			end
			if(load) begin
				time_counter <= 24'd1;
				curr_x <= start_x;
				curr_y <= start_y;
				curr_direct_x <= direction_x;
			   curr_direct_y <= direction_y;
				plot_bullet <= 1'b0;

			end
			else begin
				time_counter <= time_counter == 24'd0 ? 24'd12500000 : time_counter - 1;
				if(time_counter == 24'd0 && firing == 1'b1 && !collision) begin
					plot_bullet <= 1'b1;
					case (curr_direct_x)
						2'b00: curr_x <= curr_x;
						2'b01: curr_x <= curr_x + 3;
						2'b10: curr_x <= curr_x - 3;
						default: curr_x <= curr_x;
					endcase
				
					case (curr_direct_y)
						2'b00: curr_y <= curr_y;
						2'b01: curr_y <= curr_y - 3;
						2'b10: curr_y <= curr_y + 3;
						default: curr_y <= curr_y;	
					endcase
				end
				if (curr_x > 8'b10001011 || curr_y > 7'b1110111 || curr_x < 8'b0 || curr_y < 8'b0) begin
					firing <= 1'b0;
					plot_bullet <= 1'b0;
				end
				else if(shooting && !collision)
					firing <= 1'b1;
	
			end
		end
	
endmodule

