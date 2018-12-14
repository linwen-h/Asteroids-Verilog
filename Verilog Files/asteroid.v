module asteroid(
    input clk,
    input reset, 
    input start, //start = 1 when your asteroid has been selected

    input [3:0] direct,
    output reg moving,
    output reg [7:0] origin_x, 
    output reg [6:0] origin_y
);

reg [7:0] starting_x;
reg [6:0] starting_y;
reg [3:0] direction;

reg [23:0] counter;

always @ (posedge clk)
    begin
        if (reset) begin
<<<<<<< HEAD
           // moving <= 1'b0;
            //counter <= 24'd125000000;

            case (direct)
    	                4'b0010: begin
                            origin_x <= 8'd78;
                            origin_y <= 7'd0;
			                starting_x <= 8'd78;
                            starting_y <= 7'd0;
                            direction <= direct;
                        end
		                4'b1010: begin
                            origin_x <= 8'd139;
                            origin_y <= 7'd0;
                            starting_x <= 8'd139;
                            starting_y <= 7'd0;
                            direction <= direct;
                        end 
		                4'b1000: begin
                            origin_x <= 8'd139;
                            origin_y <= 7'd59;
                            starting_x <= 8'd139;
                            starting_y <= 7'd59;
                            direction <= direct;
                        end
		                4'b1001: begin
                            origin_x <= 8'd139;
                            origin_y <=7'd119;
                            starting_x <= 8'd139;
                            starting_y <=7'd119;
                            direction <= direct;
                        end
		                4'b0001: begin
                            origin_x <= 8'd78;
                            origin_y <= 7'd119;
                            starting_x <= 8'd78;
                            starting_y <= 7'd119;
                            direction <= direct;
                        end
		                4'b0101: begin
                            origin_x <= 8'd19;
                            origin_y <= 7'd119;
                            starting_x <= 8'd19;
                            starting_y <= 7'd119;
                            direction <= direct;
                        end
		                4'b0100: begin
                            origin_x <= 8'd19;
                            origin_y <= 7'd59;
                            starting_x <= 8'd19;
                            starting_y <= 7'd59;
                            direction <= direct;
                        end
		                4'b0110: begin
                            origin_x <= 8'd19;
                            origin_y <= 7'd0;
                            starting_x <= 8'd19;
                            starting_y <= 7'd0;
                            direction <= direct;
                        end
		                default: begin //TODO figure out a better default case
                            origin_x <= 8'd139;
                            origin_y <= 7'd0;
                            starting_x <= 8'd139;
                            starting_y <= 7'd0;
                            direction <= direct;
                        end
                    endcase
        end
        else begin
        //counter <= counter == 24'b0 ? 24'd125000000: counter - 1;
			//if (counter == 24'd0) begin

=======
            moving <= 1'b0;
            counter <= 24'd125000000;

        end
        else begin
        counter <= counter == 24'b0 ? 24'd125000000: counter - 1;
			if (counter == 24'd0) begin
>>>>>>> upstream/master
            if (~moving) begin
                if (start) begin
                    moving <= 1'b1;
                    case (direct)
    	                4'b0010: begin
<<<<<<< HEAD
                            origin_x <= 8'd78;
                            origin_y <= 7'd0;
			                starting_x <= 8'd78;
=======
                            origin_x <= 8'd79;
                            origin_y <= 7'd0;
			                starting_x <= 8'd79;
>>>>>>> upstream/master
                            starting_y <= 7'd0;
                            direction <= direct;
                        end
		                4'b1010: begin
<<<<<<< HEAD
                            origin_x <= 8'd139;
                            origin_y <= 7'd0;
                            starting_x <= 8'd139;
=======
                            origin_x <= 8'd159;
                            origin_y <= 7'd0;
                            starting_x <= 8'd159;
>>>>>>> upstream/master
                            starting_y <= 7'd0;
                            direction <= direct;
                        end 
		                4'b1000: begin
<<<<<<< HEAD
                            origin_x <= 8'd139;
                            origin_y <= 7'd59;
                            starting_x <= 8'd139;
                            starting_y <= 7'd59;
                            direction <= direct;
                        end
		                4'b1001: begin
                            origin_x <= 8'd139;
                            origin_y <=7'd119;
                            starting_x <= 8'd139;
                            starting_y <=7'd119;
                            direction <= direct;
                        end
		                4'b0001: begin
                            origin_x <= 8'd78;
                            origin_y <= 7'd119;
                            starting_x <= 8'd78;
                            starting_y <= 7'd119;
                            direction <= direct;
                        end
		                4'b0101: begin
                            origin_x <= 8'd19;
                            origin_y <= 7'd119;
                            starting_x <= 8'd19;
                            starting_y <= 7'd119;
                            direction <= direct;
                        end
		                4'b0100: begin
                            origin_x <= 8'd19;
                            origin_y <= 7'd59;
                            starting_x <= 8'd19;
                            starting_y <= 7'd59;
                            direction <= direct;
                        end
		                4'b0110: begin
                            origin_x <= 8'd19;
                            origin_y <= 7'd0;
                            starting_x <= 8'd19;
=======
                            origin_x <= 8'd159;
                            origin_y <= 7'd39;
                            starting_x <= 8'd159;
                            starting_y <= 7'd39;
                            direction <= direct;
                        end
		                4'b1001: begin
                            origin_x <= 8'd159;
                            origin_y <=7'd79;
                            starting_x <= 8'd159;
                            starting_y <=7'd79;
                            direction <= direct;
                        end
		                4'b0001: begin
                            origin_x <= 8'd79;
                            origin_y <= 7'd79;
                            starting_x <= 8'd79;
                            starting_y <= 7'd79;
                            direction <= direct;
                        end
		                4'b0101: begin
                            origin_x <= 8'd0;
                            origin_y <= 7'd79;
                            starting_x <= 8'd0;
                            starting_y <= 7'd79;
                            direction <= direct;
                        end
		                4'b0100: begin
                            origin_x <= 8'd0;
                            origin_y <= 7'd39;
                            starting_x <= 8'd0;
                            starting_y <= 7'd39;
                            direction <= direct;
                        end
		                4'b0110: begin
                            origin_x <= 8'd0;
                            origin_y <= 7'd0;
                            starting_x <= 8'd0;
>>>>>>> upstream/master
                            starting_y <= 7'd0;
                            direction <= direct;
                        end
		                default: begin //TODO figure out a better default case
<<<<<<< HEAD
                            origin_x <= 8'd139;
                            origin_y <= 7'd0;
                            starting_x <= 8'd139;
=======
                            origin_x <= 8'd79;
                            origin_y <= 7'd0;
                            starting_x <= 8'd159;
>>>>>>> upstream/master
                            starting_y <= 7'd0;
                            direction <= direct;
                        end
                    endcase
                end//end of if start
            end //end of if not moving
            else begin
<<<<<<< HEAD
                if (moving && start)  begin
=======
>>>>>>> upstream/master
		            case (direction[3:2])
			            2'b00: origin_x <= origin_x;
			            2'b01: origin_x <= origin_x + 3;
			            2'b10: origin_x <= origin_x - 3;
			            default: origin_x <= origin_x;
		            endcase
		            case (direction[1:0])
			            2'b00: origin_y <= origin_y;
			            2'b01: origin_y <= origin_y - 3;
			            2'b10: origin_y <= origin_y + 3;
			            default: origin_y <= origin_y;	
		            endcase
<<<<<<< HEAD
                end
	        end
    //end//end of counter
=======
	        end
    end//end of counter
>>>>>>> upstream/master
    end//end of else
    end//end of always
endmodule
