module keyboard(
	input clk,
	input reset,
	input controller_type // 1 = wasd, 0 = arrow key
	inout PS2_CLK,
	inout PS2_DAT,
	
	//TODO: output 
	output reg shoot,
	output reg foward,
	output  reg backward,
	output reg rotate_right,
	output reg rotate_left,
	);

	

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

	 keyboard_tracker_modified #(.PULSE_OR_HOLD(0)) k0(
	     	  .clock(clk),
		  .reset(reset),
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
			end
			else begin
				shoot <= space_pulse;
				if (controller_type) begin
					forward <= w_pulse;
					backward <= s_pulse;
					right_rotate <= d_pulse;
					left_rotate <= a_pulse;
				end
				else begin
					foward <= up_pulse;
					backward <= down_pulse;
					right_rotate <= right_pulse;
					left_rotate <= left_pulse;
				end
			end
		end
endmodule

endmodule

