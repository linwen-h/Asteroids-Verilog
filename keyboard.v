module keyboard(
	input clk,
	//input CLOCK_50,
	//input [1:0]SW, //reset - testing
	input reset,
	input controller_type, // 1 = wasd, 0 = arrow key
	inout PS2_CLK,
	inout PS2_DAT,
	
	//TODO: output 
	output reg shoot,
	output reg forward,
	output reg backward,
	output reg right_rotate,
	output reg left_rotate,
	output reg enter,
	output reg s_reset
	//output [9:0] LEDR
	);
	
	//wire controller_type;
	//assign controller_type = SW[1];
	
	
	//wire clk;
	//assign clk = CLOCK_50;
	

	 // Wires representing direct output from the keyboard controller.
	wire w_pulse,
	     a_pulse,
	     s_pulse,
	     d_pulse,
	     left_pulse,
	     right_pulse,
	     up_pulse,
	     down_pulse,
	     space_pulse,
	     enter_pulse;

	//TODO: allow user to pick if they can use WASD or Arrow Keys

			
	//TODO: update the keyboard_controller code so that 

	//assignments for testing the controls without the VGA set up
//	assign LEDR[0] = forward;
//	assign LEDR[1] = backward;
//	assign LEDR[2] = right_rotate;
//	assign LEDR[3] = left_rotate;
//	assign reset = SW[0];
//	assign LEDR[4] = shoot;
	
	//wire reset;
	
	//TODO: need to update the keyboard tracker to work for up and down keys
	//need to add pause, and go buttons and anything else
	//for menu and maybe the high score thing etc 

	 keyboard_tracker #(.PULSE_OR_HOLD(0)) k0(
	      .clock(clk),
		  .reset(~reset),
		  .PS2_CLK(PS2_CLK),
		  .PS2_DAT(PS2_DAT),
		  .w(w_pulse),
		  .a(a_pulse),
		  .s(s_pulse),
		  .d(d_pulse),
		  .left(left_pulse),
		  .right(right_pulse),
		  .up(up_pulse),
		  .down(down_pulse),
		  .space(space_pulse),
		  .enter(enter_pulse)
		  );

	always @ (posedge clk) 
		begin
			if (reset) begin
      			        // Reset signal
				shoot <= 1'b0;
				forward <= 1'b0;
				backward <= 1'b0;
				left_rotate <= 1'b0;
				right_rotate  <= 1'b0;
				enter <= 1'b0;
				s_reset <=1'b0;
			end
			else begin
				shoot <= space_pulse;
				enter <= enter_pulse;
				s_reset <= s_pulse;
				if (controller_type) begin
					forward <= w_pulse;
					right_rotate <= d_pulse;
					left_rotate <= a_pulse;
				end
				else begin
					forward <= up_pulse;
					backward <= down_pulse;
					right_rotate <= right_pulse;
					left_rotate <= left_pulse;
				end
			end
		end
endmodule

