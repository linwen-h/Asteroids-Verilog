module keyboard(
	input clk,
	input reset,
	inout PS2_CLK,
	inout PS2_DAT,
	
	//TODO: output 
	output shoot,
	output foward,
	output backward,
	output rotate_right,
	output rotate_left,
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

    // Registers holding the values displayed on the LEDs.
    	reg  w_tot,
	     a_tot,
	     s_tot,
	     d_tot,
	     left_tot,
	     right_tot,
	     up_tot,
	     down_tot,
	     space_tot,
	     enter_tot;

	//TODO: allow user to pick if they can use WASD or Arrow Keys
	assign shoot = space_tot;
	assign forward = w_tot;
	assign backward = s_tot;
	assign rotate_right = d_tot;
	assign rotate_left = a_tot;

			
	//TODO: update the keyboard_controller code so that 

	 keyboard_tracker #(.PULSE_OR_HOLD(1)) k0(
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
				w_tot <= 1'b0;
				a_tot <= 1'b0;
				s_tot <= 1'b0;
				d_tot <= 1'b0;
				
				left_tot  <= 1'b0;
				right_tot <= 1'b0;
				up_tot    <= 1'b0;
				down_tot  <= 1'b0;
				
				space_tot <= 1'b0;
				enter_tot <= 1'b0;
			
			end
			else begin
			//TODO: figure out how we want to set this up

			end
		
		end
endmodule

endmodule

