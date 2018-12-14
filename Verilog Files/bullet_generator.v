module bullet_generator(
    input clk,
    input reset, 
    input shooting,
    input [1:0] direction_x,
    input [1:0] direction_y,
    input [63:0] asteroid_x,
    input [55:0] asteroid_y,

    output [7:0] bullets_moving,
    output  [63:0] bullet_x_coord,
    output  [55:0] bullet_y_coord,
    output reg [7:0] asteroid_hit,
    output [7:0] plot_bullet

    );

    reg [7:0] bullets_fired;
    reg [7:0] load;
    reg [7:0] start_x;
    reg [6:0] start_y;
	reg [23:0] counter;

    always @ (posedge clk)begin
      if (reset) begin
        bullets_fired <= 8'd0;
        load <= 8'd0;
        start_x <= 8'd79;
        start_y <= 7'd59;
        asteroid_hit <= 8'd0;
		counter <= 24'd245000000;
      end
      else begin
	  counter <= counter == 24'b0 ? 24'd245000000: counter - 1;
	  if(counter == 24'b0) begin

        if (shooting) begin
            if(!bullets_fired[0] && shooting) begin
                bullets_fired[0] <= 1'b1;
                load[0] <= 1'b1;
            end
            else if (!bullets_fired[1] && shooting) begin
                bullets_fired[1] <= 1'b1;
                load[1] <= 1'b1;
                load[0] <= 1'b0;
            end
				else if (!bullets_fired[2] && shooting) begin
                bullets_fired[1] <= 1'b1;
                load[2] <= 1'b1;
                load[1] <= 1'b0;
					 load[0] <= 1'b0;
            end
            else begin
                load[0] <= 1'b0;
                load[1] <= 1'b0;
					 load[2] <= 1'b0;
            end

//
//            if (end_of_screen[0])begin
//                bullets_fired <= 1'b0;
//
//            end
//            else if (end_of_screen[1]) begin
//                bullets_fired <= 1'b0;
//            end
         
        end//end of if block
		end //end of counter block
      end//end of else
    end

    bullet b0 (.clk(clk), .load(load[0]), .shooting(bullets_fired[0]), .reset(reset), .firing(bullets_moving[0]), 
            .direction_x(direction_x), .direction_y(direction_y), 
		.start_x(start_x), .start_y(start_y), .collision(asteroid_hit[0]), .curr_x(bullet_x_coord[7:0]), .curr_y(bullet_y_coord[6:0]), 
        .plot_bullet(plot_bullet[0]));

    bullet b1 (.clk(clk), .load(load[1]), .shooting(bullets_fired[1]), .reset(reset), .firing(bullets_moving[1]), 
            .direction_x(direction_x), .direction_y(direction_y), 
		.start_x(start_x), .start_y(start_y), .collision(asteroid_hit[1]), .curr_x(bullet_x_coord[15:8]), .curr_y(bullet_y_coord[13:7]), 
        .plot_bullet(plot_bullet[1]));
		
	bullet b2 (.clk(clk), .load(load[2]), .shooting(bullets_fired[2]), .reset(reset), .firing(bullets_moving[2]), 
            .direction_x(direction_x), .direction_y(direction_y), 
		.start_x(start_x), .start_y(start_y), .collision(asteroid_hit[2]), .curr_x(bullet_x_coord[23:16]), .curr_y(bullet_y_coord[20:14]), 
        .plot_bullet(plot_bullet[2]));
	

        

endmodule