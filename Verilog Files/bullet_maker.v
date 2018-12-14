module bullet_maker(clk, pressed, reset, direct_x, direct_y, ship_x, ship_y);

    input clk, pressed, reset, direct_x, direct_y, ship_x, ship_y;
    localparam num_bullets = 8'd160;
    reg [7:0] count = 8'd0;

    reg [0:0]clk_array, reset_array, shooting, firing, collision, plot_bullet, load [num_bullets - 1:0];
    reg [1:0] direction_x, direction_y [num_bullets - 1:0];
    reg [7:0] start_x, curr_x [num_bullets - 1:0];
    reg [6:0] start_y, curr_y [num_bullets - 1:0];

    integer i, k;
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

    always @ (posedge clk)
        begin: make_new_bullets
            if (reset) begin
                count <= 8'b0;

                for(k = 0; k < num_bullets; k = k + 1)
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
			shooting[count - 1] <= 1'b0;
                    end
	        end
            end
        end
endmodule
