module asteroid_generator(
    input game_clk, //game clock [0] reset [1]
    input reset,
    output [7:0] moving_block,
    output [63:0] x_coords,
    output [55:0] y_coords,
<<<<<<< HEAD
	output [7:0] spaceship_collisions,
  output reg[0:0] gameover,

    output [5:0] LEDR //lives
=======
	output [7:0] spaceship_collisions

    //output [9:0] LEDR //[7:4] direction, [3:0] past_direction
>>>>>>> upstream/master
	  //output [6:0] HEX0, //curr_x [3:0]
	  //output [6:0] HEX1, //curr_x [7:4]
	  //output [6:0] HEX3, //curr_y [3:0]
	  //output [6:0] HEX4  //curr_y [0] + [6:4]
    
);

reg [7:0] ship_collision;
assign spaceship_collisions = ship_collision;
	//hex_seg(HEX0, x_coords[3:0]);
	//hex_seg(HEX1, x_coords[7:4]);
	//hex_seg(HEX3, y_coords[3:0]);
	//hex_seg(HEX4, {1'b0, y_coords[6:4]});

wire [7:0] asteroid_moving;

assign moving_block = asteroid_moving;
//assign LEDR [5:4] = asteroid_moving;
//assign LEDR [7:6] = asteroid_starts;
reg [7:0] asteroid_starts;

wire [3:0] rand_direction;
//assign LEDR[3:0] = rand_direction;

reg [7:0] asteroids_reset;
reg [3:0] test_direction;
reg [3:0] direction_1;
reg [3:0] direction_2;

wire [8:0] x_coord_0, x_coord_1;
wire [7:0] y_coord_0, y_coord_1;


assign x_coord_0 = {1'b0, x_coords[7:0]};
assign y_coord_0 = {1'b0,y_coords[6:0]};
assign x_coord_1 = {1'b0, x_coords[15:8]};
assign y_coord_1 = {1'b0, y_coords[13:7]};

reg [23:0] counter;
<<<<<<< HEAD
reg clk_pulse;
reg [3:0] delay;
reg [3:0] lives;
assign LEDR[3:0] = lives;
assign LEDR[5] = gameover;
=======

>>>>>>> upstream/master


random_generator rand(game_clk, reset, rand_direction);
    always @ (posedge game_clk)
        begin: moving
	        if (reset) begin 
          //todo: figure out how to use verilog for loops
            asteroid_starts <= 8'd0;
            asteroids_reset <= 8'b11111111;
            ship_collision <= 8'd0;
<<<<<<< HEAD
            lives <= 4'b0111;
				gameover <=1'b0;
				  
				  counter <= 24'd24500000000;
          clk_pulse <= 1'b0;
          delay <= 4'b0;
=======
				  
				  counter <= 24'd245000000000;
>>>>>>> upstream/master
				
				 
	        end

	        else begin
<<<<<<< HEAD
          if(counter == 24'b0) begin
            counter <= 24'd24500000000;
            clk_pulse <= ~clk_pulse;
            delay <= delay + 1'b1;

          end
          else
            counter <= counter - 1;
			    //counter <= counter == 24'b0 ? 24'd245000000000: counter - 1;

			  if (counter == 24'd0) begin

        	  if ((delay == 4'd3) && (rand_direction != 4'b0000) && (rand_direction != 4'b0011) && (rand_direction != 4'b0111) && (rand_direction != 4'b1011) && (rand_direction != 4'b1100) && (rand_direction != 4'b1101) && (rand_direction != 4'b1110) && (rand_direction != 4'b1111)) begin
              delay <= 4'd0;
              if((asteroid_starts[0] == 1'b0) ) begin
=======
			  counter <= counter == 24'b0 ? 24'd245000000000: counter - 1;
			  if (counter == 24'd0) begin
			  
        	  if ((rand_direction != 4'b0000) && (rand_direction != 4'b0011) && (rand_direction != 4'b0111) && (rand_direction != 4'b1011) && (rand_direction != 4'b1100) && (rand_direction != 4'b1101) && (rand_direction != 4'b1110) && (rand_direction != 4'b1111)) begin
              if((asteroid_starts[0] == 1'b0) || ship_collision[0]) begin
>>>>>>> upstream/master
                asteroid_starts[0] <= 1'b1;
                asteroids_reset[0] <= 1'b1;
                test_direction <= rand_direction;
                ship_collision[0] <= 1'b0;
                //direction_1 <= rand_direction;
              end
<<<<<<< HEAD
              else if ((asteroid_starts[1] == 1'b0) )  begin
=======
              else if ((asteroid_starts[1] == 1'b0) || ship_collision[1])  begin
>>>>>>> upstream/master
                asteroid_starts[1] <= 1'b1;
                test_direction <= rand_direction;
                asteroids_reset[0] <= 1'b0;
                asteroids_reset[1] <= 1'b1;
                ship_collision[1] <= 1'b0;
                //direction_2 <= rand_direction;
              end
<<<<<<< HEAD
              else if ((asteroid_starts[2] == 1'b0) ) begin
=======
              else if ((asteroid_starts[2] == 1'b0) || ship_collision[2]) begin
>>>>>>> upstream/master
                asteroid_starts[2] <= 1'b1;
                test_direction <= rand_direction;
                asteroids_reset[1] <= 1'b0;
                asteroids_reset[2] <= 1'b1;
                ship_collision[2] <= 1'b0;
              end
<<<<<<< HEAD
              else if ((asteroid_starts[3] == 1'b0) ) begin
=======
              else if ((asteroid_starts[3] == 1'b0) || ship_collision[3]) begin
>>>>>>> upstream/master
                asteroid_starts[3] <= 1'b1;
                test_direction <= rand_direction;
                asteroids_reset[2] <= 1'b0;
                asteroids_reset[3] <= 1'b1;
                ship_collision[3] <= 1'b0;
              end
              else if ((asteroid_starts[4] == 1'b0) || ship_collision[4]) begin
                asteroid_starts[4] <= 1'b1;
                test_direction <= rand_direction;
                asteroids_reset[3] <= 1'b0;
                asteroids_reset[4] <= 1'b1;
                ship_collision[4] <= 1'b0;
              end
              else if ((asteroid_starts[5] == 1'b0) || ship_collision[5]) begin
                asteroid_starts[5] <= 1'b1;
                test_direction <= rand_direction;
                asteroids_reset[4] <= 1'b0;
                asteroids_reset[5] <= 1'b1;
                ship_collision[5] <= 1'b0;
              end
              else if ((asteroid_starts[6] == 1'b0) || ship_collision[6]) begin
                asteroid_starts[6] <= 1'b1;
                test_direction <= rand_direction;
                asteroids_reset[5] <= 1'b0;
                asteroids_reset[6] <= 1'b1;
                ship_collision[6] <= 1'b0;
              end
              else if ((asteroid_starts[7] == 1'b0) || ship_collision[7]) begin
                asteroid_starts[7] <= 1'b1;
                test_direction <= rand_direction;
                asteroids_reset[6] <= 1'b0;
                asteroids_reset[7] <= 1'b1;
                ship_collision[7] <= 1'b0;
              end
              else begin //if all asteroids are running then this on the next clock cycle stops the asteroid from reseting
                asteroids_reset[0] <= 1'b0;
                asteroids_reset[1] <= 1'b0;
                asteroids_reset[2] <= 1'b0;
                asteroids_reset[3] <= 1'b0;
                asteroids_reset[4] <= 1'b0;
                asteroids_reset[5] <= 1'b0;
                asteroids_reset[6] <= 1'b0;
                asteroids_reset[7] <= 1'b0;
              end
            end //huge if block end 
<<<<<<< HEAD
            if (asteroid_starts[0] && (x_coords[7:0] <= 9'd84) && (x_coords[7:0] >= 9'd72) && (y_coords[6:0] <= 8'd65) && (y_coords[6:0] >= 8'd53)) begin
                    //ship_collision[0] <= 1'b1;
                    //asteroid_starts[0] <= 1'b0;
                    asteroids_reset[0] <= 1'b1;
                    test_direction <= rand_direction;
					if (lives == 4'b0111) begin
						lives <= 4'b0011;
					end
					else if (lives == 4'b0011) begin
						lives <= 4'b001;
					end 
					else if (lives == 4'b0001) begin
						lives <= 4'b0000;
					end
                    
	          end 
            else if (asteroid_starts[1] && (x_coords[15:8] <= 9'd84) && (x_coords[15:8] >= 9'd72) && (y_coords[13:7] <= 8'd65) && (y_coords[13:7] >= 8'd53)) begin
                    //ship_collision[1] <= 1'b1;
                    //asteroid_starts[1] <= 1'b1;
                    asteroids_reset[1] <= 1'b1;
                    test_direction <= rand_direction;
                    if (lives == 4'b0111) begin
						lives <= 4'b0011;
					end
					else if (lives == 4'b0011) begin
						lives <= 4'b001;
					end 
					else if (lives == 4'b0001) begin
						lives <= 4'b0000;
					end
                    
             
	          end
            else if (asteroid_starts[2] && (x_coords[23:16] <= 9'd84) && (x_coords[23:16] >= 9'd72) && (y_coords[20:14] <= 8'd65) && (y_coords[20:14] >= 8'd53)) begin
                    //ship_collision[2] <= 1'b1;
                    //asteroid_starts[2] <= 1'b0;
                    asteroids_reset[2] <= 1'b1;
                    test_direction <= rand_direction;
                    if (lives == 4'b0111) begin
						lives <= 4'b0011;
					end
					else if (lives == 4'b0011) begin
						lives <= 4'b001;
					end 
					else if (lives == 4'b0001) begin
						lives <= 4'b0000;
					end
                    
             
	          end
            else if (asteroid_starts[3] && (x_coords[31:24] <= 9'd84) && (x_coords[31:24] >= 9'd74) && (y_coords[27:21] <= 8'd65) && (y_coords[27:21] >= 8'd53)) begin
                    //ship_collision[3] <= 1'b1;
                    //asteroid_starts[3] <= 1'b0;
                    asteroids_reset[3] <= 1'b1;
                    test_direction <= rand_direction;
                    if (lives == 4'b0111) begin
						lives <= 4'b0011;
					end
					else if (lives == 4'b0011) begin
						lives <= 4'b001;
					end 
					else if (lives == 4'b0001) begin
						lives <= 4'b0000;
					end
                    
             
	          end

            else if (asteroid_starts[4] && (x_coords[31:24] <= 9'd84) && (x_coords[31:24] >= 9'd74) && (y_coords[27:21] <= 8'd65) && (y_coords[27:21] >= 8'd53)) begin
                    //ship_collision[3] <= 1'b1;
                    //asteroid_starts[3] <= 1'b0;
                    asteroids_reset[4] <= 1'b1;
                    test_direction <= rand_direction;
                    if (lives == 4'b0111) begin
						lives <= 4'b0011;
					end
					else if (lives == 4'b0011) begin
						lives <= 4'b001;
					end 
					else if (lives == 4'b0001) begin
						lives <= 4'b0000;
					end
                    
             
	          end
            if (lives == 4'd0)
                      gameover <= 1'b1;
            // else if (delay == 4'd2) begin //if all asteroids are running then this on the next clock cycle stops the asteroid from reseting
            //     asteroids_reset[0] <= 1'b0;
            //     asteroids_reset[1] <= 1'b0;
            //     asteroids_reset[2] <= 1'b0;
            //     asteroids_reset[3] <= 1'b0;
            //     asteroids_reset[4] <= 1'b0;
            //     asteroids_reset[5] <= 1'b0;
            //     asteroids_reset[6] <= 1'b0;
            //     asteroids_reset[7] <= 1'b0;
                
            //   end
            //if it reaches
            // else if (asteroid_starts[4] && (x_coords[39:32] <= 9'd80) && (x_coords[39:32] >= 9'd76) && (y_coords[34:28] <= 8'd61) && (y_coords[34:28] >= 8'd57)) begin
            //         ship_collision[4] <= 1'b1;
             
	          // end
            // else if (asteroid_starts[5] && (x_coords[47:40] <= 9'd80) && (x_coords[47:40] >= 9'd76) && (y_coords[41:35] <= 8'd61) && (y_coords[41:35] >= 8'd57)) begin
            //         ship_collision[5] <= 1'b1;
             
	          // end
            // else if (asteroid_starts[6] && (x_coords[55:48] <= 9'd80) && (x_coords[55:48] >= 9'd76) && (y_coords[48:42] <= 8'd61) && (y_coords[48:42] >= 8'd57)) begin
            //         ship_collision[6] <= 1'b1;
             
	          // end
            // else if (asteroid_starts[7] && (x_coords[63:56] <= 9'd80) && (x_coords[63:56] >= 9'd76) && (y_coords[55:49] <= 8'd61) && (y_coords[55:49] >= 8'd57)) begin
            //         ship_collision[7] <= 1'b1;
             
	          // end 
=======
            if (!ship_collision[0] && (x_coords[7:0] <= 9'd81) && (x_coords[7:0] >= 9'd77) && (y_coords[6:0] <= 8'd41) && (y_coords[6:0] >= 8'd37)) begin
                    ship_collision[0] <= 1'b1;
	          end 
            else if (!ship_collision[1] && (x_coords[15:8] <= 9'd81) && (x_coords[15:8] >= 9'd77) && (y_coords[13:7] <= 8'd41) && (y_coords[13:7] >= 8'd37)) begin
                    ship_collision[1] <= 1'b1;
             
	          end
            else if (asteroid_starts[2] && (x_coords[23:16] <= 9'd81) && (x_coords[23:16] >= 9'd77) && (y_coords[20:14] <= 8'd41) && (y_coords[20:14] >= 8'd37)) begin
                    ship_collision[2] <= 1'b1;
             
	          end
            else if (asteroid_starts[3] && (x_coords[31:24] <= 9'd81) && (x_coords[31:24] >= 9'd77) && (y_coords[27:21] <= 8'd41) && (y_coords[27:21] >= 8'd37)) begin
                    ship_collision[3] <= 1'b1;
             
	          end
            else if (asteroid_starts[4] && (x_coords[39:32] <= 9'd81) && (x_coords[39:32] >= 9'd77) && (y_coords[34:28] <= 8'd41) && (y_coords[34:28] >= 8'd37)) begin
                    ship_collision[4] <= 1'b1;
             
	          end
            else if (asteroid_starts[5] && (x_coords[47:40] <= 9'd81) && (x_coords[47:40] >= 9'd77) && (y_coords[41:35] <= 8'd41) && (y_coords[41:35] >= 8'd37)) begin
                    ship_collision[5] <= 1'b1;
             
	          end
            else if (asteroid_starts[6] && (x_coords[55:48] <= 9'd81) && (x_coords[55:48] >= 9'd77) && (y_coords[48:42] <= 8'd41) && (y_coords[48:42] >= 8'd37)) begin
                    ship_collision[6] <= 1'b1;
             
	          end
            else if (asteroid_starts[7] && (x_coords[63:56] <= 9'd81) && (x_coords[63:56] >= 9'd77) && (y_coords[55:49] <= 8'd41) && (y_coords[55:49] >= 8'd37)) begin
                    ship_collision[7] <= 1'b1;
             
	          end 
>>>>>>> upstream/master
            
			end //end of counter clock
          end//end of else
        end//end of always block

    asteroid a0(
<<<<<<< HEAD
        .clk(clk_pulse),
=======
        .clk(game_clk),
>>>>>>> upstream/master
        .reset(asteroids_reset[0]),
        .start(asteroid_starts[0]),
        .direct(test_direction),
        .origin_x(x_coords[7:0]),
        .origin_y(y_coords[6:0]),
        .moving(asteroid_moving[0])
        );
    
    asteroid a1(
<<<<<<< HEAD
        .clk(clk_pulse),
=======
        .clk(game_clk),
>>>>>>> upstream/master
        .reset(asteroids_reset[1]),
        .start(asteroid_starts[1]),
        .direct(test_direction),
        .origin_x(x_coords[15:8]),
        .origin_y(y_coords[13:7]),
        .moving(asteroid_moving[1])
<<<<<<< HEAD

        );

    asteroid a2(
        .clk(clk_pulse),
=======
        );

    asteroid a2(
        .clk(game_clk),
>>>>>>> upstream/master
        .reset(asteroids_reset[2]),
        .start(asteroid_starts[2]),
        .direct(test_direction),
        .origin_x(x_coords[23:16]),
        .origin_y(y_coords[20:14]),
        .moving(asteroid_moving[2])
        );

    asteroid a3(
<<<<<<< HEAD
        .clk(clk_pulse),
=======
        .clk(game_clk),
>>>>>>> upstream/master
        .reset(asteroids_reset[3]),
        .start(asteroid_starts[3]),
        .direct(test_direction),
        .origin_x(x_coords[31:24]),
        .origin_y(y_coords[27:21]),
        .moving(asteroid_moving[3])
        );

    // asteroid a4(
    //     .clk(game_clk),
    //     .reset(asteroids_reset[4]),
    //     .start(asteroid_starts[4]),
    //     .direct(test_direction),
    //     .origin_x(x_coords[39:32]),
    //     .origin_y(y_coords[34:28]),
    //     .moving(asteroid_moving[4])
    //     );      

    //  asteroid a5(
    //     .clk(game_clk),
    //     .reset(asteroids_reset[5]),
    //     .start(asteroid_starts[5]),
    //     .direct(test_direction),
    //     .origin_x(x_coords[47:40]),
    //     .origin_y(y_coords[41:35]),
    //     .moving(asteroid_moving[5])
    //     ); 

    // asteroid a6(
    //     .clk(game_clk),
    //     .reset(asteroids_reset[6]),
    //     .start(asteroid_starts[6]),
    //     .direct(test_direction),
    //     .origin_x(x_coords[55:48]),
    //     .origin_y(y_coords[48:42]),
    //     .moving(asteroid_moving[6])
    //     );  

    // asteroid a7(
    //     .clk(game_clk),
    //     .reset(asteroids_reset[7]),
    //     .start(asteroid_starts[7]),
    //     .direct(test_direction),
    //     .origin_x(x_coords[63:56]),
    //     .origin_y(y_coords[55:49]),
    //     .moving(asteroid_moving[7])
    //     );
endmodule