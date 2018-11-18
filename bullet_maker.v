module bullet_maker(clk, pressed, reset, direct_x, direct_y, ship_x, ship_y);

    input clk, pressed, reset, direct_x, direct_y, ship_x, ship_y;
    localparam num_bullets = 8'd160;
    reg [7:0] count = 8'd0;

    reg clk_array [num_bullets - 1:0];
    reg reset_array [num_bullets - 1:0];
	reg shooting [num_bullets - 1:0];
	reg firing [num_bullets - 1:0];
	reg collision [num_bullets - 1:0];
	reg plot_bullet [num_bullets - 1:0];
	reg load [num_bullets - 1:0];
    reg [1:0] direction_x, direction_y [num_bullets - 1:0];
    reg [7:0] start_x [num_bullets - 1:0];
    reg [7:0] curr_x [num_bullets - 1:0];
    reg [6:0] start_y[num_bullets - 1:0];
    reg [6:0] curr_y [num_bullets - 1:0];

    integer i;
    initial begin
        for(i = 0; i < num_bullets; i = i + 1)
            clk_array[i] <= clk;
            shooting[i] <= 1'b0;
		    load[i] <= 1'b0;
            reset_array[i] <= 1'b1;
            collision[i] <= 1'b0;
            start_x[i] <= 8'd0;
            start_y[i] <= 7'd0;
            direction_x[i] <= 2'b00;
            direction_y[i] <= 2'b00;
    end 

	genvar j;
	generate
	for (j = 0; j < num_bullets; j = j + 1)
		begin: generate_bullets
			bullet bullet_instance(
				.clk(clk), 
				.load(load[j]), 
				.shooting(shooting[j]),
				.reset(reset_array[j]), 
				.firing(firing[j]),
				.direction_x(direction_x[j]), 
				.direction_y(direction_y[j]), 
				.start_x(start_x[j]),
				.start_y(start_y[j]), 
				.collision(collision[j]), 
				.curr_x(curr_x[j]), 
				.curr_y(curr_y[j]), 
				.plot_bullet(plot_bullet[j])
			);
		end
	endgenerate

    //bullet bullet_array[num_bullets - 1:0] (.clk(clk_array),
      //                      .reset(reset_array),
        //                    .firing(firing),
          //                  .shooting(shooting),
		//	    .load(load),
                  //          .direction_x(direction_x),
                    //        .direction_y(direction_y),
                      //      .start_x(start_x),
                       //     .start_y(start_y),
                         //   .collision(collision),
                          //  .curr_x(curr_x),
                           // .curr_y(curr_y),
                            //.plot_bullet(plot_bullet));

    //outputs: curr_x, curr_y, plot_bullet, firing

    always @ (posedge clk)
        begin: make_new_bullets
            if (reset) begin
                count <= 8'b0;
            end
            else begin 
                if(count == num_bullets - 1) begin
                    count = 7'd0;
                    reset_array[0] = 1'b1;
                end

                if (pressed) begin
                    direction_x[count] <= direct_x;
                    direction_y[count] <= direct_y;
                    start_x[count] <= ship_x;
                    start_y[count] <= ship_y;
                    reset_array[count] <= 1'b1;
                    shooting[count] <= 1'b1;
					load[count] <= 1'b1;
                    count <= count + 1'b1;
				    if (count > 0) begin
						load[count-1] <= 1'b0;
                    end
				end
            end
        end
endmodule


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
