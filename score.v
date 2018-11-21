module score (
	input clk,
	input reset,
	inout hit,
	output [5:0] curr_score);
	
	always @ (posegde clk)
		begin
			if (reset) begin
				curr_score = 6'd0;
			end 
			else begin
				if (hit) begin
					curr_score = curr_score + 1'b1;
					hit = 1'b0;
				end
		end

endmodule
